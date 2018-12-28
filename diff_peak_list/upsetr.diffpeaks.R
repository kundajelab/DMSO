rm(list=ls())
library(UpSetR)
data=read.table("upsetr.peak.input.txt",header=TRUE,sep='\t')
data$Chrom=NULL
data$Start=NULL
data$End=NULL
upset(data,sets=names(data),order.by = "freq",text.scale=3)