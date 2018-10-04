rm(list=ls())
library(ggplot2)
library(limma)
library(sva)
library(gplots)
#import data 
tpm=read.table("../counts/counts.atac.lowdensity.cellcycle",header=FALSE,sep='\t')
tpm=voom(tpm)
tpm=tpm$E
batches=data.frame(read.table('../counts/counts.metadata.atac.lowdensity.cellcycle',header=TRUE,sep='\t'))

names(tpm)=batches$Rep
#pca.original=prcomp(t(tpm))
#barplot(100*pca.original$sdev^2/sum(pca.original$sdev^2),las=2,xlab="",ylab="% Variance Explained")
#groups=(rownames(pca.original$x))
#plot(pca.original$x[,c(1,2)],pch=16)
#text(pca.original$x[,c(1,2)],labels=groups,pos=3)


#get the design matrix 
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

#sva on asinh(tpm)
sva_tpm=sva(as.matrix(tpm),mod1,mod0)
sva_tpm=data.frame(sva_tpm$sv)
batches$sva1=sva_tpm$X1
batches$sva2=sva_tpm$X2
#add in surrogate variables into the model matrix
mod3=model.matrix(~0+Sample+sva1+sva2,data=batches)
fit2 <- lmFit(as.matrix(tpm), mod3)
#subtract the SV contribs
sv_contribs=coefficients(fit2)[,c(7,8)] %*% t(fit2$design[,c(7,8)])
tpm_corrected=na.omit(tpm-sv_contribs) 
colnames(tpm_corrected)=batches[,1]
peak_names=read.table("../merged_peaks/ppr.merged.bed",header=FALSE,sep=',')
rownames(tpm_corrected)=peak_names$V1
write.table(tpm_corrected,"atac_corrected.csv",row.names=TRUE,col.names=TRUE,sep='\t',quote=FALSE)

## perform a PCA to measure how much SVA correction helped! 
#original data: 


mod_final=model.matrix(~0+Sample,data=batches)
fit_tpm <-lmFit(tpm_corrected,mod_final)
#specify the contrasts
cont.matrix=makeContrasts(earlyg1_dmso_control="SampleearlyG1.LD.treated-SampleearlyG1.LD.controls ",
                          lateg1_dmso_control="SamplelateG1.LD.treated-SamplelateG1.LD.controls",
                          sg2m_dmso_control="SampleSG2M.LD.treated-SampleSG2M.LD.controls",
                          levels=mod_final)
limma_coefs=seq(3)
comparison_names=c("earlyG1",
                   "lateG1",
                   "SG2M")

#USE LIMMA ANALYSIS
fit_tpm=contrasts.fit(fit_tpm,cont.matrix)
e_tpm=eBayes(fit_tpm)
library(broom)
library(dplyr)
for(contrast_index in seq(1,3))
{
  comparison_name=unlist(comparison_names[contrast_index])
  la_tpm=topTable(e_tpm,number=nrow(tpm_corrected),coef=contrast_index,p.value = 0.01)
  la_tpm$Gene=rownames(la_tpm)
  up_genes=la_tpm$Gene[la_tpm$logFC > 1]
  down_genes=la_tpm$Gene[la_tpm$logFC < -1]
  write.table(up_genes,paste(comparison_names[contrast_index],"up",sep='.'),row.names = FALSE,col.names = FALSE,quote=FALSE)
  write.table(down_genes,paste(comparison_names[contrast_index],"down",sep='.'),row.names=FALSE,col.names=FALSE,quote=FALSE)
}


