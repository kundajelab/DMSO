rm(list=ls())
library(ggplot2)
library(limma)
library(edgeR)
library(DESeq2)
library(sva)
library(gplots)
#import data 
tpm=read.table("../counts/counts.atac.lowdensity.cellcycle",header=FALSE,sep='\t')
tpm=voom(tpm)
tpm=tpm$E
batches=data.frame(read.table('atacseq_batches.txt',header=TRUE,sep='\t'))

#all_zero_indices=which(rowSums(tpm)==0)
#tpm=tpm[-all_zero_indices,]
#tpm=asinh(tpm)


names(tpm)=batches$Rep
names(tpm_corrected)=batches$Rep
pca.original=prcomp(t(tpm))
pca.corrected=prcomp(t(tpm_corrected))
barplot(100*pca.original$sdev^2/sum(pca.original$sdev^2),las=2,xlab="",ylab="% Variance Explained")
barplot(100*pca.corrected$sdev^2/sum(pca.corrected$sdev^2),las=2,xlab="",ylab="% Variance Explained")
groups=(rownames(pca.original$x))
plot(pca.original$x[,c(1,2)],pch=16)
text(pca.original$x[,c(1,2)],labels=groups,pos=3)
plot(pca.corrected$x[,c(1,3)],pch=16)
text(pca.corrected$x[,c(1,3)],labels=groups,pos=3)


#get the design matrix 
batches=data.frame(read.table('atacseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

#sva on asinh(tpm)
sva_tpm=sva(as.matrix(tpm),mod1,mod0)
sva_tpm=data.frame(sva_tpm$sv)
browser() 
batches$sva1=sva_tpm$X1
batches$sva2=sva_tpm$X2
#add in surrogate variables into the model matrix
mod3=model.matrix(~0+Sample+sva1+sva2,data=batches)
fit2 <- lmFit(as.matrix(tpm), mod3)
#subtract the SV contribs
sv_contribs=coefficients(fit2)[,c(7,8)] %*% t(fit2$design[,c(7,8)])
tpm_corrected=na.omit(tpm-sv_contribs) 
## perform a PCA to measure how much SVA correction helped! 
#original data: 




mod_final=model.matrix(~0+Sample,data=batches)
fit_tpm <-lmFit(tpm_corrected,mod_final)
#specify the contrasts
cont.matrix=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                          lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                          sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                          lateg1_earlyg1_dmso="Samplet.lateG1-Samplet.earlyG1",
                          sg2m_lateg1_dmso="Samplet.SG2M-Samplet.lateG1",
                          earlyg1_sg2m_dmso="Samplet.earlyG1-Samplet.SG2M",
                          lateg1_earlyg1_control="Samplec.lateG1-Samplec.earlyG1",
                          sg2m_lateg1_control="Samplec.SG2M-Samplec.lateG1",
                          earlyg1_sg2m_control="Samplec.earlyG1-Samplec.SG2M",
                          levels=mod_final)
limma_coefs=seq(9)
comparison_names=c("earlyG1",
                   "lateG1",
                   "SG2M",
                   "lateG1_vs_earlyG1_t",
                   "SG2M_vs_lateG1_t",
                   "earlyG1_vs_SG2M_t",
                   "lateG1_vs_earlyG1_c",
                   "SG2M_vs_lateG1_c",
                   "earlyG1_vs_SG2M_c")

#USE LIMMA ANALYSIS
fit_tpm=contrasts.fit(fit_tpm,cont.matrix)
e_tpm=eBayes(fit_tpm)
library(broom)
library(dplyr)
for(contrast_index in seq(1,9))
{
  comparison_name=unlist(comparison_names[contrast_index])
  la_tpm=topTable(e_tpm,number=nrow(tpm_corrected),coef=contrast_index,p.value = 0.05,lfc = 1)
  la_tpm$Gene=rownames(la_tpm)
  up_genes=la_tpm$Gene[la_tpm$logFC > 0.9]
  down_genes=la_tpm$Gene[la_tpm$logFC < -0.9]
  write.table(up_genes,paste(comparison_names[contrast_index],"up",sep='.'),row.names = FALSE,col.names = FALSE,quote=FALSE)
  write.table(down_genes,paste(comparison_names[contrast_index],"down",sep='.'),row.names=FALSE,col.names=FALSE,quote=FALSE)
}


