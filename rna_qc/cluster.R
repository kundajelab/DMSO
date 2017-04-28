rm(list=ls())
library(ggplot2)
library(DESeq2)
library(reshape2)
counts=read.table("rsem.expected_count.tsv",header=TRUE,sep='\t',row.names=1)
counts=round(counts)
all_zero_indices=which(rowSums(counts)==0)
counts=counts[-all_zero_indices,]
rn=rownames(counts)
counts=rlogTransformation(as.matrix(counts))
rownames(counts)=rn

tpm=read.table("rsem.tpm.csv",header=TRUE,sep='\t',row.names=1)
all_zero_indices=which(rowSums(tpm)==0)
tpm=tpm[-all_zero_indices,]
tpm=asinh(tpm)

batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
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

#  data.pca=prcomp(t(tpm_corrected))
#  barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),width=1,xlim=c(0,13),ylim=c(0,100),xlab="PC",ylab="% Variance Explained")
#  text(1:12,100*data.pca$sdev^2/sum(data.pca$sdev^2),labels=round(100*data.pca$sdev^2/sum(data.pca$sdev^2),2))
#  
# groups=factor(rownames(data.pca$x))
# control_treated_groups=factor(c(1,1,1,1,1,1,
#                                 2,2,2,2,2,2))
# time_groups=factor(c(1,1,2,2,3,3,1,1,2,2,3,3))
# rep_groups=factor(c(1,1,2,2,3,3,4,4,5,5,6,6))
# 
# par(mfrow=c(2,2))
# plot(data.pca$x[,c(1,2)],col=control_treated_groups,pch=16)
# text(data.pca$x[,c(1,2)],labels=groups,pos=3,cex=1)
# title("PC1 vs PC2")
# plot(data.pca$x[,c(1,3)],col=time_groups,pch=16)
# text(data.pca$x[,c(1,3)],labels=groups,pos=3,cex=1)
# title("PC1 vs PC3")
# plot(data.pca$x[,c(2,3)],col=time_groups,pch=16)
# text(data.pca$x[,c(2,3)],labels=groups,pos=3,cex=1)
# title("PC2 vs PC3")
# plot(data.pca$x[,c(3,4)],col=time_groups,pch = 16)
# text(data.pca$x[,c(3,4)],labels=groups,pos=3,cex=1)
#title("PC3 vs PC4")
#plot(data.pca$x[,c(2,5)],col=groups,pch = 16)
#text(data.pca$x[,c(2,5)],labels=groups,pos=3,cex=1)
#title("PC2 vs PC5") 
#kmeans clustering 



#get colMeans and colSD, grouped by cluster, define some helper functions  
#means 
clust_colMeans<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  data_subset$cluster=NULL
  return(colMeans(data_subset))
}

#standard deviation
clust_sd<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  data_subset$cluster=NULL
  return(apply(data_subset,2,sd))
}

#cluster size 
clust_size<-function(data,cluster){
  data_subset=data[data$cluster==cluster,]
  df=data.frame(size=nrow(data_subset),
                cluster=cluster)
  return(df)
}

library(fpc)
library(ggplot2)
c25 <- c("dodgerblue2","#E31A1C", # red
         "green4",
         "#6A3D9A", # purple
         "#FF7F00", # orange
         "black","gold1",
         "skyblue2","#FB9A99", # lt pink
         "palegreen2",
         "#CAB2D6", # lt purple
         "#FDBF6F", # lt orange
         "gray70", "khaki2",
         "maroon","orchid1","deeppink1","blue1","steelblue4",
         "darkturquoise","green1","yellow4","yellow3",
         "darkorange4","brown")
#average counts 
k=15
fit <- kmeans(counts, k)
counts_df=as.data.frame(counts)
counts_df$cluster=fit$cluster
mean_counts_df=data.frame(c.earlyG1=rowMeans(cbind(counts_df$c.earlyG1.r1,counts_df$c.earlyG1.r2)),
                          c.lateG1=rowMeans(cbind(counts_df$c.lateG1.r1,counts_df$c.lateG1.r2)),
                          c.SG2M=rowMeans(cbind(counts_df$c.SG2M.r1,counts_df$c.SG2M.r2)),
                          t.earlyG1=rowMeans(cbind(counts_df$t.earlyG1.r1,counts_df$t.earlyG1.r2)),
                          t.lateG1=rowMeans(cbind(counts_df$t.lateG1.r1,counts_df$t.lateG1.r2)),
                          t.SG2M=rowMeans(cbind(counts_df$t.SG2M.r1,counts_df$t.SG2M.r2)))
rownames(mean_counts_df)=rownames(counts_df)

# Centroid Plot against 1st 2 discriminant functions
clus_num=1
cur_means=clust_colMeans(counts_df,clus_num)
cur_sd=clust_sd(counts_df,clus_num)
cur_size=clust_size(counts_df,clus_num)

for(clus_num in seq(2,k))
{
  cur_means=rbind(cur_means,clust_colMeans(counts_df,clus_num))
  cur_sd=rbind(cur_sd,clust_sd(counts_df,clus_num))
  cur_size=rbind(cur_size,clust_size(counts_df,clus_num))
}
rownames(cur_means)=NULL
rownames(cur_sd)=NULL
means_melted=melt(fit$centers)
means_melted$Var1=factor(means_melted$Var1)
cur_size$size=factor(fit$size)

ggplot(means_melted,aes(x=means_melted$Var2,
                        y=means_melted$value,
                        group=means_melted$Var1,
                        colour=means_melted$Var1,
                        shape=means_melted$Var1))+
  geom_line(size=1.2)+
  xlab("Timepoint")+
  ylab("mean(rlogTransform(Counts))")+
  scale_color_discrete(labels=as.character(cur_size$size),
                     name="Cluster Size",
                     breaks=cur_size$cluster)+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90))

mean_counts_df=data.frame(c.earlyG1=rowMeans(cbind(counts_df$c.earlyG1.r1,counts_df$c.earlyG1.r2)),
                          c.lateG1=rowMeans(cbind(counts_df$c.lateG1.r1,counts_df$c.lateG1.r2)),
                          c.SG2M=rowMeans(cbind(counts_df$c.SG2M.r1,counts_df$c.SG2M.r2)),
                          t.earlyG1=rowMeans(cbind(counts_df$t.earlyG1.r1,counts_df$t.earlyG1.r2)),
                          t.lateG1=rowMeans(cbind(counts_df$t.lateG1.r1,counts_df$t.lateG1.r2)),
                          t.SG2M=rowMeans(cbind(counts_df$t.SG2M.r1,counts_df$t.SG2M.r2)))
rownames(mean_counts_df)=rownames(counts_df)
par(mfrow=c(5,4))
for(k in seq(2,20))
{
fit <- kmeans(mean_counts_df, k)
means_melted=melt(fit$centers)
means_melted$Var1=factor(means_melted$Var1)
ggplot(means_melted,aes(x=means_melted$Var2,
                        y=means_melted$value,
                        colour=means_melted$Var1))+
  geom_point(size=5)+
  xlab("Timepoint")+
  ylab("mean(rlogTransform(Counts))")+
  scale_color_discrete(labels=as.character(fit$size),
                       name="Cluster Size",
                       breaks=seq(1,k))+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90))
browser()

}
