rm(list=ls())
library(ggplot2)
earlyG1=read.table("earlyG1.diff.fc",header=FALSE,sep='\t')
lateG1=read.table("lateG1.diff.fc",header=FALSE,sep='\t')
SG2M=read.table("SG2M.diff.fc",header=FALSE,sep='\t')

p1=ggplot(data=earlyG1,aes(x=earlyG1$V2))+
  geom_histogram(bins=50,fill="#7570b3")+
  geom_vline(xintercept=1.55)+
  geom_vline(xintercept=-1.19)+
  xlab("log2(earlyG1 DMSO TPM/ earlyG1 Control TPM)")+
  ylab("Number of Genes")+
  ggtitle("EarlyG1: mean upregulated = 1.55; mean downregulated=-1.19")


p2=ggplot(data=lateG1)+
  geom_histogram(data=lateG1,aes(x=lateG1$V2),bins=50,fill="#d95f02")+
  geom_vline(xintercept=1.85)+
  geom_vline(xintercept=-1.18)+
  xlab("log2(lateG1 DMSO TPM/ lateG1 Control TPM)")+
  ylab("Number of Genes")+
  ggtitle("lateG1: mean upregulated = 1.85; mean downregulated=-1.18")



p3=ggplot(data=SG2M)+
  geom_histogram(data=SG2M,aes(x=SG2M$V2),bins=50,fill="#1b9e77")+
  geom_vline(xintercept=1.72)+
  geom_vline(xintercept=-0.99)+
  xlab("log2(SG2M DMSO TPM/ SG2M Control TPM)")+
  ylab("Number of Genes")+
  ggtitle("SG2M: mean upregulated = 1.72; mean downregulated=-0.99")

source("~/helpers.R")
multiplot(p1,p2,p3,cols=1)
