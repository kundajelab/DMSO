rm(list=ls())
library(ggplot2)
library(limma)
data=read.table("atac.counts.HK.txt",header=TRUE,sep='\t')
data=data[,4:15]
normd=voom(counts=data,normalize.method = "quantile")$E
normd=as.data.frame(normd)

earlyG1_controls=rowMeans(normd[,1:2])
earlyG1_dmso=rowMeans(normd[,3:4])
lateG1_controls=rowMeans(normd[,5:6])
lateG1_dmso=rowMeans(normd[,7:8])
sg2m_controls=rowMeans(normd[,9:10])
sg2m_dmso=rowMeans(normd[,11:12])

norm_collapsed=data.frame(earlyG1_controls,earlyG1_dmso,lateG1_controls,lateG1_dmso,sg2m_controls,sg2m_dmso)
data=norm_collapsed

p1= ggplot(data=data)+
    geom_point(aes(x=data$earlyG1_controls,y=data$earlyG1_dmso,alpha=0.1))+
    ggtitle("earlyG1 controls vs earlyG1 DMSO")+
    xlab("earlyG1 controls")+
    ylab("earlyG1 DMSO")

p2= ggplot(data=data)+
  geom_point(aes(x=data$lateG1_controls,y=data$lateG1_dmso,alpha=0.1))+
  ggtitle("lateG1 controls vs lateG1 DMSO")+
  xlab("lateG1 controls")+
  ylab("lateG1 DMSO")


p3= ggplot(data=data)+
  geom_point(aes(x=data$sg2m_controls,y=data$sg2m_dmso,alpha=0.1))+
  ggtitle("SG2M controls vs SG2M DMSO")+
  xlab("SG2M Controls")+
  ylab("SG2M DMSO")


source('~/helpers.R')
multiplot(p1,p2,p3,cols=3)


