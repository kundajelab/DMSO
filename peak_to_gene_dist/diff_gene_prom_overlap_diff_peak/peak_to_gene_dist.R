rm(list=ls())
dist=read.table("distance_to_closest_peak_from_promoter.txt",header=FALSE,sep='\t')
names(dist)=c("V1","V2")
dist$V2[dist$V2<1]=1
library(ggplot2)
p1=ggplot()+
  stat_ecdf(data=dist,aes(x=dist$V2))+
  geom_vline(xintercept=1000)+
  geom_vline(xintercept=5000)+
  geom_vline(xintercept=10000)+
  geom_vline(xintercept=50000)+
  geom_vline(xintercept=100000)+
  geom_vline(xintercept=500000)+
  geom_vline(xintercept=1000000)+
  geom_vline(xintercept=2000000)+
  scale_x_continuous(trans='log10') +
  xlab("Distance from promoter of differential gene (N=2906) to nearest differential peak")+
  ylab("CDF")


