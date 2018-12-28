rm(list=ls())
library(ggplot2)
library(reshape2)
data=read.table("cell_cycle_formatted.csv",header=TRUE,sep='\t',stringsAsFactors = FALSE)

ccna1=data[data$Gene=='CCNA1',]
ccna1$Sample=factor(ccna1$Sample,levels=ccna1$Sample)

CDK1=data[data$Gene=='CDK1',]
CDK1$Sample=factor(CDK1$Sample,levels=CDK1$Sample)

CCNB1=data[data$Gene=='CCNB1',]
CCNB1$Sample=factor(CCNB1$Sample,levels=CCNB1$Sample)

UBE2C=data[data$Gene=='UBE2C',]
UBE2C$Sample=factor(UBE2C$Sample,levels=UBE2C$Sample)

AURKA=data[data$Gene=='AURKA',]
AURKA$Sample=factor(AURKA$Sample,levels=AURKA$Sample)

p1=ggplot(data=ccna1,
          aes(x=Sample,
              y=Mean))+
  geom_bar(stat='identity')+
  geom_errorbar(data=ccna1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("CCNA1")+
  theme_bw(20)+
  ylab("TPM")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p2=ggplot(data=CDK1,
          aes(x=Sample,
              y=Mean))+
  geom_bar(stat='identity')+
  geom_errorbar(data=CDK1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("CDK1")+
  theme_bw(20)+
  ylab("TPM")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


p3=ggplot(data=CCNB1,
          aes(x=Sample,
              y=Mean))+
  geom_bar(stat='identity')+
  geom_errorbar(data=CCNB1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("CCNB1")+
  theme_bw(20)+
  ylab("TPM")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p4=ggplot(data=UBE2C,
          aes(x=Sample,
              y=Mean))+
  geom_bar(stat='identity')+
  geom_errorbar(data=UBE2C,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("UBE2C")+
  theme_bw(20)+
  ylab("TPM")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p5=ggplot(data=AURKA,
          aes(x=Sample,
              y=Mean))+
  geom_bar(stat='identity')+
  geom_errorbar(data=AURKA,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("AURKA")+
  theme_bw(20)+
  ylab("TPM")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

source("~/helpers.R")
multiplot(p1,p2,p3,p4,p5,cols=3)




