rm(list=ls())
library(ggplot2)
library(limma)
library(sva)
library(dplyr)

#get the design matrix 
batches=data.frame(read.table('atacseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)
#import data 
counts=read.table("../counts/counts.atac.lowdensity.cellcycle",header=FALSE,sep='\t')
peak_names=read.table("../merged_peaks/ppr.merged.bed",header=FALSE,sep=',')
rownames(counts)=peak_names$V1
#remove all-0 values 
all_zero_indices=which(rowSums(counts)==0)
counts=counts[-all_zero_indices,]
names(counts)=batches$Rep
groups=colnames(counts)

#rlogTransform on the data 
#This function transform the count data to the log2 scale in a way which minimizes differences between samples 
#for rows with small counts, and which normalizes with respect to library size. 
rlog_counts=rlogTransformation(as.matrix(counts))
rownames(rlog_counts)=rownames(counts)
pca.original=prcomp(t(rlog_counts))
barplot(100*pca.original$sdev^2/sum(pca.original$sdev^2),las=2,xlab="",ylab="% Variance Explained")
plot(pca.original$x[,c(1,2)],pch=16)
text(pca.original$x[,c(1,2)],labels=groups,pos=3)
plot(pca.original$x[,c(2,3)],pch=16)
text(pca.original$x[,c(2,3)],labels=groups,pos=3)
plot(pca.original$x[,c(1,3)],pch=16)
text(pca.original$x[,c(1,3)],labels=groups,pos=3)


#sva on rlogTransform(counts)
sva_rlog_counts=sva(rlog_counts,mod1,mod0)
sva_rlog_counts=data.frame(sva_rlog_counts$sv)
batches$sva1=sva_rlog_counts$X1
batches$sva2=sva_rlog_counts$X2
#add in surrogate variables into the model matrix

mod2=cbind(mod1,sva_rlog_counts)
fit <- lmFit(rlog_counts,mod2)
sv_contribs=coefficients(fit)[,c(5,6)] %*% t(fit$design[,c(5,6)])
data_corrected=rlog_counts-sv_contribs

#run pca on corrected data 
pca.corrected=prcomp(t(data_corrected))
barplot(100*pca.corrected$sdev^2/sum(pca.corrected$sdev^2),las=2,xlab="",ylab="% Variance Explained")
plot(pca.corrected$x[,c(1,2)],pch=16)
text(pca.corrected$x[,c(1,2)],labels=groups,pos=3)
plot(pca.corrected$x[,c(2,3)],pch=16)
text(pca.corrected$x[,c(2,3)],labels=groups,pos=3)
plot(pca.corrected$x[,c(1,3)],pch=16)
text(pca.corrected$x[,c(1,3)],labels=groups,pos=3)

#specify the contrasts
mod3=model.matrix(~0+Sample,data=batches)
fit2 <- lmFit(data_corrected, mod3)

cont.matrix=makeContrasts(earlyg1_dmso_control="Sampleatac_earlyG1_ld_treated-Sampleatac_earlyG1_ld_control",
                          lateg1_dmso_control="Sampleatac_lateG1_ld_treated-Sampleatac_lateG1_ld_control",
                          sg2m_dmso_control="Sampleatac_SG2M_ld_treated-Sampleatac_SG2M_ld_control",
                          lateg1_earlyg1_dmso="Sampleatac_lateG1_ld_treated-Sampleatac_earlyG1_ld_treated",
                          sg2m_lateg1_dmso="Sampleatac_SG2M_ld_treated-Sampleatac_lateG1_ld_treated",
                          earlyg1_sg2m_dmso="Sampleatac_earlyG1_ld_treated-Sampleatac_SG2M_ld_treated",
                          lateg1_earlyg1_control="Sampleatac_lateG1_ld_control-Sampleatac_earlyG1_ld_control",
                          sg2m_lateg1_control="Sampleatac_SG2M_ld_control-Sampleatac_lateG1_ld_control",
                          earlyg1_sg2m_control="Sampleatac_earlyG1_ld_control-Sampleatac_SG2M_ld_control",
                          levels=mod3)
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
fit=contrasts.fit(fit2,cont.matrix)
e_voomcounts=eBayes(fit)
la=topTable(e_voomcounts,p.value = 0.1,lfc = 1,n=nrow(e_voomcounts))
write.table(la,"differential_atacseq_peaks.limma_on_rlogTransform_counts_with_sva_removed.txt",row.names = TRUE,col.names = TRUE,quote=FALSE,sep='\t')
