rm(list=ls())
library(ggplot2)
library(DESeq2)
library(reshape2)
library(ggplot2)
#read in tpm
tpm=read.table("../rsem.tpm.csv",header=TRUE,sep='\t',row.names=1)
all_zero_indices=which(rowSums(tpm)==0)
tpm=tpm[-all_zero_indices,]
tpm=asinh(tpm)

#sva on tpm 
batches=data.frame(read.table('../rnaseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)
library(sva)
library(limma) 
sva_tpm=sva(as.matrix(tpm),mod1,mod0)
sva_tpm=data.frame(sva_tpm$sv)
batches$sva1=sva_tpm$X1
batches$sva2=sva_tpm$X2
batches$sva3=sva_tpm$X3
#add in surrogate variables into the model matrix
mod3=model.matrix(~0+Sample+sva1+sva2+sva3,data=batches)
fit2 <- lmFit(as.matrix(tpm), mod3)
#subtract the SV contribs
sv_contribs=coefficients(fit2)[,c(7,8,9)] %*% t(fit2$design[,c(7,8,9)])
tpm_corrected=na.omit(tpm-sv_contribs) 
mean_tpm_corrected=data.frame(c.earlyG1=rowMeans(cbind(tpm_corrected$c.earlyG1.r1,tpm_corrected$c.earlyG1.r2)),
                              c.lateG1=rowMeans(cbind(tpm_corrected$c.lateG1.r1,tpm_corrected$c.lateG1.r2)),
                              c.SG2M=rowMeans(cbind(tpm_corrected$c.SG2M.r1,tpm_corrected$c.SG2M.r2)),
                              t.earlyG1=rowMeans(cbind(tpm_corrected$t.earlyG1.r1,tpm_corrected$t.earlyG1.r2)),
                              t.lateG1=rowMeans(cbind(tpm_corrected$t.lateG1.r1,tpm_corrected$t.lateG1.r2)),
                              t.SG2M=rowMeans(cbind(tpm_corrected$t.SG2M.r1,tpm_corrected$t.SG2M.r2)))
rownames(mean_tpm_corrected)=rownames(tpm_corrected)
############################################################################################################
gene_list="SG2M.up"
#extract the genes we care about 
subset=read.table(gene_list,header=FALSE,sep='\t',stringsAsFactors = FALSE)
mean_tpm_corrected=mean_tpm_corrected[subset$V1,]
#tpm-corrected
k=100
set.seed(12345)
fit=kmeans(mean_tpm_corrected,k)
#agglomerative clustering 
centroids=fit$centers 
hist(fit$cluster,k)
d <- dist(centroids, method = "euclidean") # distance matrix
set.seed(12345)
hc <- hclust(d, method="average")
plot(hc) # display dendogram
numgroups=8
groups=cutree(hc,numgroups)
nonredundant_hclust=rect.hclust(hc, k=numgroups, border="red")

library(dplyr)
mean_tpm_corrected$cluster=fit$cluster
groups=data.frame(seq(1,k),groups)
names(groups)=c("cluster","group")
merged=full_join(mean_tpm_corrected,groups,by="cluster")
merged$Subject=rownames(data)
merged$Gene=rownames(mean_tpm_corrected)
for(i in seq(1,numgroups))
{
  write.table(merged$Gene[merged$group==i],file=paste(gene_list,i,sep="."),quote=FALSE,row.names = FALSE,col.names = FALSE)
}