rm(list=ls())
library(ggplot2)
library(limma)
library(edgeR)
library(DESeq2)
library(sva)
library(gplots)
#import data 
counts=read.table("rsem.expected_count.tsv",header=TRUE,sep='\t',row.names=1)
counts=round(counts)
all_zero_indices=which(rowSums(counts)==0)
counts=counts[-all_zero_indices,]
rn=rownames(counts)
counts=rlogTransformation(as.matrix(counts))
rownames(counts)=rn


#get the design matrix 
batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

counts_corrected=na.omit(counts) 
mod_final=model.matrix(~0+Sample,data=batches)
fit_counts <- lmFit(counts_corrected, mod_final)
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
fit_counts=contrasts.fit(fit_counts,cont.matrix)
e_counts=eBayes(fit_counts)
for(contrast_index in seq(1,9))
{
  comparison_name=unlist(comparison_names[contrast_index])
  la_counts=topTable(e_counts,number=nrow(counts_corrected),coef=contrast_index,lfc = 1, p.value = 0.1)
  la_counts$Gene=rownames(la_counts)
  up_genes=la_counts$Gene[la_counts$logFC > 0.9]
  down_genes=la_counts$Gene[la_counts$logFC < -0.9]
  write.table(up_genes,paste(comparison_names[contrast_index],"up",sep='.'),row.names = FALSE,col.names = FALSE,quote=FALSE)
  write.table(down_genes,paste(comparison_names[contrast_index],"down",sep='.'),row.names=FALSE,col.names=FALSE,quote=FALSE)
  
}