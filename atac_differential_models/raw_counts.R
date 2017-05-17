rm(list=ls())
library(ggplot2)
library(limma)
library(edgeR)
library(DESeq2)
library(sva)
library(gplots)
library(broom)
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
pca.original=prcomp(t(counts))
barplot(100*pca.original$sdev^2/sum(pca.original$sdev^2),las=2,xlab="",ylab="% Variance Explained")
plot(pca.original$x[,c(2,3)],pch=16)
text(pca.original$x[,c(2,3)],labels=groups,pos=3)
#svaseq on counts
sva_counts=svaseq(as.matrix(counts),mod1,mod0)
sva_counts=data.frame(sva_counts$sv)
batches$sva1=sva_counts$X1
batches$sva2=sva_counts$X2
#add in surrogate variables into the model matrix
mod2=model.matrix(~0+Sample+sva1+sva2,data=batches)
norm_data=voom(counts,design=mod2)
fit <- lmFit(norm_data)
#specify the contrasts
cont.matrix=makeContrasts(earlyg1_dmso_control="Sampleatac_earlyG1_ld_treated-Sampleatac_earlyG1_ld_control",
                          lateg1_dmso_control="Sampleatac_lateG1_ld_treated-Sampleatac_lateG1_ld_control",
                          sg2m_dmso_control="Sampleatac_SG2M_ld_treated-Sampleatac_SG2M_ld_control",
                          lateg1_earlyg1_dmso="Sampleatac_lateG1_ld_treated-Sampleatac_earlyG1_ld_treated",
                          sg2m_lateg1_dmso="Sampleatac_SG2M_ld_treated-Sampleatac_lateG1_ld_treated",
                          earlyg1_sg2m_dmso="Sampleatac_earlyG1_ld_treated-Sampleatac_SG2M_ld_treated",
                          lateg1_earlyg1_control="Sampleatac_lateG1_ld_control-Sampleatac_earlyG1_ld_control",
                          sg2m_lateg1_control="Sampleatac_SG2M_ld_control-Sampleatac_lateG1_ld_control",
                          earlyg1_sg2m_control="Sampleatac_earlyG1_ld_control-Sampleatac_SG2M_ld_control",
                          levels=mod2)
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
fit=contrasts.fit(fit,cont.matrix)
e_voomcounts=eBayes(fit)
la=topTable(e_voomcounts,p.value = 0.01,lfc = 1,n=nrow(e_voomcounts))
write.table(la,"differential_atacseq_peaks.limmavoom_on_counts_with_svaseq_added_to_model.txt",row.names = TRUE,col.names = TRUE,quote=FALSE,sep='\t')
