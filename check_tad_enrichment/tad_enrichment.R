rm(list=ls())
atac=read.table("atac_summary.df",header=TRUE,sep='\t')
library(reshape2)
atac_reshaped=melt(atac)
d2=read.table("extract.atac")
library(ggplot2)
ggplot(data=atac_reshaped,
       aes(y=atac_reshaped$value,
           x=atac_reshaped$variable,colour="Expected"))+
  geom_boxplot()+
  geom_point(data=d2,aes(x=d2$V1,y=d2$V2,colour='Observed'))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  ylab("Number of differential ATAC-seq peaks")+
  xlab("TAD region")+
  ggtitle("Permutation test boxplot vs observed count of differential ATAC-seq peaks in tads")

gene=read.table("gene_summary.df",header=TRUE,sep='\t')
library(reshape2)
gene_reshaped=melt(gene)
d2=read.table("extract.gene")
library(ggplot2)
ggplot(data=gene_reshaped,
       aes(y=gene_reshaped$value,
           x=gene_reshaped$variable,colour="Expected"))+
  geom_boxplot()+
  geom_point(data=d2,aes(x=d2$V1,y=d2$V2,colour='Observed'))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  ylab("Number of differential genes")+
  xlab("TAD region")+
  ggtitle("Permutation test boxplot vs observed count of differential genes in tads")

