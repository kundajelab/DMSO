rm(list=ls())
dist5e2=read.table("distances.5e2",header=FALSE,sep='\t')
dist5e2=as.data.frame(dist5e2[order(dist5e2$V1),])
names(dist5e2)=c("V1")

diste2=read.table("distances.e2",header=FALSE,sep='\t')
diste2=as.data.frame(diste2[order(diste2$V1),])
names(diste2)=c("V1")


diste3=read.table("distances.e3",header=FALSE,sep='\t')
diste3=as.data.frame(diste3[order(diste3$V1),])
names(diste3)=c("V1")


diste4=read.table("distances.e4",header=FALSE,sep='\t')
diste4=as.data.frame(diste4[order(diste4$V1),])
names(diste4)=c("V1")

diste5=read.table("distances.e5",header=FALSE,sep='\t')
diste5=as.data.frame(diste5[order(diste5$V1),])
names(diste5)=c("V1")

library(ggplot2)
p1=ggplot()+
  stat_ecdf(data=dist5e2,aes(x=dist5e2$V1,color="padj<5e-2; n=13592"))+
  stat_ecdf(data=diste2,aes(x=diste2$V1,color="padj<1e-2; n=5709"))+
  stat_ecdf(data=diste3,aes(x=diste3$V1,color="padj<1e-3; n=1564"))+
  stat_ecdf(data=diste4,aes(x=diste4$V1,color="padj<1e-4; n=431"))+
  stat_ecdf(data=diste5,aes(x=diste5$V1,color="padj<1e-5; n=88"))+
  xlim(0,1e6)+
  scale_color_manual(values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e'),name="DESeq2 threshold")+
  xlab("Distance from differential ATACseq-peak to neareat differential gene")+
  ylab("CDF")


