rm(list=ls())
library(ggplot2)
data=read.table("summary.pos.neg.sum.txt",header=TRUE,sep='\t')
data$Pos=data$Pos-100
pou5f1=ggplot(data=data)+
  geom_line(aes(x=data$Pos,y=data$earlyG1.controls.pou5f1,color="earlyG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$earlyG1.dmso.pou5f1,color="earlyG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.controls.pou5f1,color="lateG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.dmso.pou5f1,color="lateG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.controls.pou5f1,color="SG2M Controls"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.dmso.pou5f1,color="SG2M DMSO"))+
  scale_color_manual(name="Sample",values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02'))+
  xlab("Distance from Motif Center")+
  ylab("Average Cuts")+
  ggtitle("POU5F1")+
  theme_bw(20)

smad3=ggplot(data=data)+
  geom_line(aes(x=data$Pos,y=data$earlyG1.controls.smad3,color="earlyG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$earlyG1.dmso.smad3,color="earlyG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.controls.smad3,color="lateG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.dmso.smad3,color="lateG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.controls.smad3,color="SG2M Controls"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.dmso.smad3,color="SG2M DMSO"))+
  scale_color_manual(name="Sample",values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02'))+
  xlab("Distance from Motif Center")+
  ylab("Average Cuts")+
  ggtitle("SMAD3")+
  theme_bw(20)


sox8=ggplot(data=data)+
  geom_line(aes(x=data$Pos,y=data$earlyG1.controls.sox8,color="earlyG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$earlyG1.dmso.sox8,color="earlyG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.controls.sox8,color="lateG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.dmso.sox8,color="lateG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.controls.sox8,color="SG2M Controls"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.dmso.sox8,color="SG2M DMSO"))+
  scale_color_manual(name="Sample",values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02'))+
  xlab("Distance from Motif Center")+
  ylab("Average Cuts")+
  ggtitle("SOX8")+
  theme_bw(20)

tead1=ggplot(data=data)+
  geom_line(aes(x=data$Pos,y=data$earlyG1.controls.tead1,color="earlyG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$earlyG1.dmso.tead1,color="earlyG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.controls.tead1,color="lateG1 Controls"))+
  geom_line(aes(x=data$Pos,y=data$lateG1.dmso.tead1,color="lateG1 DMSO"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.controls.tead1,color="SG2M Controls"))+
  geom_line(aes(x=data$Pos,y=data$SG2M.dmso.tead1,color="SG2M DMSO"))+
  scale_color_manual(name="Sample",values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02'))+
  xlab("Distance from Motif Center")+
  ylab("Average Cuts")+
  ggtitle("TEAD1")+
  theme_bw(20)
