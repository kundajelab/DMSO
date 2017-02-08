rm(list=ls())
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)
data=data.frame(read.table('macs.fc.averaged.cellcycleonly.tab',header=TRUE,sep='\t'))
data=asinh(data)
#data[data>200]=1 #remove any outliers!!
batches=data.frame(read.table('batches.txt',header=TRUE,sep='\t'))
mod=model.matrix(~Condition+Density+CellCyclePoint+Condition*Density+Condition*CellCyclePoint+Density*CellCyclePoint,data=batches)
mod0=model.matrix(~1,data=batches)
groups=factor(names(data))
data=as.matrix(data)
sva1 = sva(data,mod,mod0,method="irw")
sur_var=sva1$sv

plot(sur_var[,1],sur_var[,2],pch=16)
text(sur_var[,1],sur_var[,2],labels=groups,pos=3,cex=0.5)
title("Var 1 vs Var 2")


plot(sur_var[,1],sur_var[,3],pch=16)
text(sur_var[,1],sur_var[,3],labels=groups,pos=3,cex=0.5)
title("Var 1 vs Var 3")


plot(sur_var[,1],sur_var[,4],pch=16)
text(sur_var[,1],sur_var[,4],labels=groups,pos=3,cex=0.5)
title("Var 1 vs Var 4")


plot(sur_var[,2],sur_var[,3],pch=16)
text(sur_var[,2],sur_var[,3],labels=groups,pos=3,cex=0.5)
title("Var 2 vs Var 3")

plot(sur_var[,2],sur_var[,4],pch=16)
text(sur_var[,2],sur_var[,4],labels=groups,pos=3,cex=0.5)
title("Var 2 vs Var 4")


plot(sur_var[,3],sur_var[,4],pch=16)
text(sur_var[,3],sur_var[,4],labels=groups,pos=3,cex=0.5)
title("Var 3 vs Var 4")

full.model.sv=cbind(mod,sur_var)
library(limma)
fit <- lmFit(data, full.model.sv)
sv_contribs=coefficients(fit)[,c(11,12)] %*% t(fit$design[,c(11,12)])
data_corrected=data-sv_contribs
write.csv(data_corrected,"atac_corrected.csv")
