rm(list=ls())
library(ggplot2)
old=read.table("old.rsem.tpm.csv",header=TRUE,sep='\t')
new=read.table("rsem.genes.tpm",header=TRUE,sep='\t')
merged=merge(old,new,by="GENE")
old=merged[,1:13]
new=merged[,c(1,15:26)]