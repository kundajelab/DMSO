rm(list=ls())
library(ggplot2)

earlyG1up=read.table("earlyG1.up.dist.txt",header=FALSE,sep='\t')
earlyG1down=read.table("earlyG1.down.dist.txt",header=FALSE,sep='\t')
lateG1up=read.table("lateG1.up.dist.txt",header=FALSE,sep='\t')
lateG1down=read.table("lateG1.down.dist.txt",header=FALSE,sep='\t')
SG2Mup=read.table("SG2M.up.dist.txt",header=FALSE,sep='\t')
SG2Mdown=read.table("SG2M.down.dist.txt",header=FALSE,sep='\t')

names(earlyG1up)=c("V1","V2")
earlyG1up$V2[earlyG1up$V2<1]=1
names(earlyG1down)=c("V1","V2")
earlyG1down$V2[earlyG1down$V2<1]=1

names(lateG1up)=c("V1","V2")
lateG1up$V2[lateG1up$V2<1]=1
names(lateG1down)=c("V1","V2")
lateG1down$V2[lateG1down$V2<1]=1

names(SG2Mup)=c("V1","V2")
SG2Mup$V2[SG2Mup$V2<1]=1
names(SG2Mdown)=c("V1","V2")
SG2Mdown$V2[SG2Mdown$V2<1]=1


p1=ggplot()+
  stat_ecdf(data=earlyG1up,aes(x=earlyG1up$V2,color="earlyG1 Up N=485"))+
  stat_ecdf(data=earlyG1down,aes(x=earlyG1down$V2,color="earlyG1 Down N=354"))+
  stat_ecdf(data=lateG1up,aes(x=lateG1up$V2,color="lateG1 Up N=868"))+
  stat_ecdf(data=lateG1down,aes(x=lateG1down$V2,color="lateG1 Down N=1059"))+
  stat_ecdf(data=SG2Mup,aes(x=SG2Mup$V2,color="SG2M Up 711"))+
  stat_ecdf(data=SG2Mdown,aes(x=SG2Mdown$V2,color="SG2M Down 370"))+
  geom_vline(xintercept=1000)+
  geom_vline(xintercept=5000)+
  geom_vline(xintercept=10000)+
  geom_vline(xintercept=50000)+
  geom_vline(xintercept=100000)+
  geom_vline(xintercept=500000)+
  geom_vline(xintercept=1000000)+
  geom_vline(xintercept=2000000)+
  scale_color_manual(values=c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c'),name="Diff Gene Set")+
  scale_x_continuous(trans='log10') +
  xlab("Distance from promoter of differential gene  to nearest differential peak")+
  ylab("CDF")


