rm(list=ls())
source('~/helpers.R')
library(ggplot2)

data=read.table("atac.counts.txt",header=TRUE,sep='\t')
rownames(data)=paste(data$Chrom,data$Start,data$End,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL



batches=read.table("../atacseq_batches_truerep.txt",header=TRUE,sep='\t')
batches$Sample=factor(batches$Sample)
batches$CellCycle=factor(batches$CellCycle)
batches$Treatment=factor(batches$Treatment)

data.pca=prcomp(t(data),center=FALSE,scale=TRUE)
barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),width=1,xlim=c(0,13),ylim=c(0,100),xlab="PC",ylab="% Variance Explained")
text(1:12,100*data.pca$sdev^2/sum(data.pca$sdev^2),labels=round(100*data.pca$sdev^2/sum(data.pca$sdev^2),2))


#ggplot pca fig
pca_df=as.data.frame(data.pca$x)
pca_df=cbind(pca_df,batches)

p1=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC2,color=pca_df$CellCycle,shape=pca_df$Treatment))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC1: 95.77%")+
  ylab("PC2: 1.35%")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="none")


p2=ggplot(data=pca_df,aes(x=pca_df$PC2,y=pca_df$PC3,color=pca_df$CellCycle,shape=pca_df$Treatment))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC2: 1.35%")+
  ylab("PC3: 0.94%")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="none")

p3=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC3,color=pca_df$CellCycle,shape=pca_df$Treatment))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC1: 95.77%")+
  ylab("PC3: 0.94%")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="bottom")

multiplot(p1,p2,p3,cols=1)


