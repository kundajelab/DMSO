rm(list=ls())
library(limma)
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)

data=data.frame(read.table('chipseq_merged.txt',header=TRUE,sep='\t'))
chrom=data$Chrom
start_pos=data$Start
end_pos=data$End
unique_names=paste(chrom,start_pos,end_pos,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL
rownames(data)=unique_names

batches=data.frame(read.table('chipseq_batches.txt',header=TRUE,sep='\t'))

mod1=model.matrix(~0+Sample,data=batches)
v=voom(counts=data,design=mod1)
fit <- lmFit(v)
plotMDS(v)

#specify the contrasts 
cont.matrix=makeContrasts(h3k27ac_dmso_control="Samplechip_h3k27ac_dmso-Samplechip_h3k27ac_control",
                          h3k4me3_dmso_control="Samplechip_h3k4me3_dmso-Samplechip_h3k4me3_control",
                          h3k27me3_dmso_control="Samplechip_h3k27me3_dmso-Samplechip_h3k27me3_control",
                          levels=mod1)
fit2=contrasts.fit(fit,cont.matrix)
e=eBayes(fit2)
comparisons=colnames(cont.matrix)
gene_names=unique_names
for(i in seq(1,3))
{
  tab<-topTable(e, number=nrow(data),coef=i,lfc=1,p.value = 0.001)
  names(tab)[1]=comparisons[i]
  tab$Chrom_Start_End=rownames(tab)
  write.table(tab,file=paste("differential_peaks_",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
}
