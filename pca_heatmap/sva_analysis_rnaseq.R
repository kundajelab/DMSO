rm(list=ls())
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)
#data=data.frame(read.table('rsem.results.filtered',header=TRUE,sep='\t'))
data=data.frame(read.table('rsem.expected_count.filtered.tsv',header=TRUE,sep='\t'))
data$GENE=NULL
data=asinh(data)
#data[data>200]=1 #remove any outliers!!
batches=data.frame(read.table('batches_rnaseq.txt',header=TRUE,sep='\t'))
mod=model.matrix(~Condition+CellCyclePoint+Condition*CellCyclePoint,data=batches)
mod0=model.matrix(~1,data=batches)
groups=factor(names(data))
data=as.matrix(data)
sva1 = sva(data,mod,mod0,method="irw")
sur_var=sva1$sv
full.model.sv=cbind(mod,sur_var)
library(limma)
fit <- lmFit(data, full.model.sv)
browser() 
sv_contribs=coefficients(fit)[,c(7)] %*% t(fit$design[,c(7)])
data_corrected=data-sv_contribs
write.csv(data_corrected,"rsem.expected_count.sva_corrected.csv")



