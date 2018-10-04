rm(list=ls())
library(UpSetR)
data=read.table("upsetr.peak.input.txt",header=TRUE,sep='\t')
upset(data,nsets=6,order.by = "freq")