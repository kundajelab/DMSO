rm(list=ls())
library(limma)
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)

data=data.frame(read.table('rnaseq_merged.txt',header=TRUE,sep='\t'))
unique_names=data$Gene
rownames(data)=unique_names
data$Gene=NULL

batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
#pc1 is weird -- no correspondence to DMSO vs Control or Timepoint , need to perform SVA
mod1=model.matrix(~0+Sample,data=batches)
v=voom(counts=data,design=mod1)
write.csv(v$E,"rnaseq_normalized.txt")
fit <- lmFit(v)
plotMDS(v)
cont.matrix=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                          lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                          sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                          lateg1_earlyg1_dmso="Samplet.lateG1-Samplet.earlyG1",
                          sg2m_lateg1_dmso="Samplet.SG2M-Samplet.lateG1",
                          earlyg1_sg2m_dmso="Samplet.earlyG1-Samplet.SG2M",
                          lateg1_earlyg1_control="Samplec.lateG1-Samplec.earlyG1",
                          sg2m_lateg1_control="Samplec.SG2M-Samplec.lateG1",
                          earlyg1_sg2m_control="Samplec.earlyG1-Samplec.SG2M",
                          levels=mod1)
fit2=contrasts.fit(fit,cont.matrix)
e=eBayes(fit2)
comparisons=colnames(cont.matrix)
gene_names=unique_names
for(i in seq(1,9))
{
  tab<-topTable(e, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
  names(tab)[1]=comparisons[i]
  tab$Chrom_Start_End=rownames(tab)
  write.table(tab,file=paste("rna_differential_",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
}
