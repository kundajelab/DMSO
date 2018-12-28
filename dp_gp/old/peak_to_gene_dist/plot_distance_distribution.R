rm(list=ls())
library(ggplot2)
source('helpers.R')
i=1
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p1=ggplot(data,aes(x=V1,group=V2,color=V2))+
    stat_ecdf(size=2)+
    xlab("")+
    ylab("")+
    ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), " ,\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
    guides(color=FALSE)+
    theme_bw(20)
i=2
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p2=ggplot(data,aes(x=V1,group=V2,color=V2))+
  stat_ecdf(size=2)+
  xlab("")+
  ylab("")+
  ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), " ,\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
  guides(color=FALSE)+
  theme_bw(20)
i=3
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p3=ggplot(data,aes(x=V1,group=V2,color=V2))+
  stat_ecdf(size=2)+
  xlab("")+
  ylab("")+
  ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), " ,\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
  guides(color=FALSE)+
  theme_bw(20)
i=4
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p4=ggplot(data,aes(x=V1,group=V2,color=V2))+
  stat_ecdf(size=2)+
  xlab("")+
  ylab("")+
  ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), " ,\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
  guides(color=FALSE)+
  theme_bw(20)

i=5
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p5=ggplot(data,aes(x=V1,group=V2,color=V2))+
  stat_ecdf(size=2)+
  xlab("")+
  ylab("")+
  ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), " ,\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
  guides(color=FALSE)+
  theme_bw(20)

i=6
data=read.table(paste(i,".dist",sep=""),header=FALSE,sep='\t')
ks_result=ks.test(data$V1[data$V2=="foreground"],data$V1[data$V2=="background"],alternative="greater")
p6=ggplot(data,aes(x=V1,group=V2,color=V2))+
  stat_ecdf(size=2)+
  xlab("")+
  ylab("")+
  ggtitle(paste("cluster",i," KS=",round(ks_result$statistic,2), ",\nP=",formatC(ks_result$p.value, format = "e", digits = 2),sep=""))+
  guides(color=FALSE)+
  theme_bw(20)

svg(filename="fig2c.svg",height=20,width=5)
multiplot(p1,p2,p3,p4,p5,p6,cols=1)
dev.off() 
