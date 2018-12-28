rm(list=ls())
library(ggplot2)
library(reshape2)
data=read.table("cell_cycle_formatted.lines.csv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data$DMSOvsControl=factor(data$DMSOvsControl)
ccna1=data[data$Gene=='CCNA1',]
#ccna1$Sample=factor(ccna1$Sample,levels=ccna1$Sample)

CDK1=data[data$Gene=='CDK1',]
#CDK1$Sample=factor(CDK1$Sample,levels=CDK1$Sample)

CCNB1=data[data$Gene=='CCNB1',]
#CCNB1$Sample=factor(CCNB1$Sample,levels=CCNB1$Sample)

UBE2C=data[data$Gene=='UBE2C',]
#UBE2C$Sample=factor(UBE2C$Sample,levels=UBE2C$Sample)

AURKA=data[data$Gene=='AURKA',]
#AURKA$Sample=factor(AURKA$Sample,levels=AURKA$Sample)

CDT1=data[data$Gene=='CDT1',]
GMNN=data[data$Gene=='GMNN',]
CCND1=data[data$Gene=='CCND1',]
CCND3=data[data$Gene=='CCND3',]
CCND2=data[data$Gene=='CCND2',]
CDK4=data[data$Gene=='CDK4',]
CDK6=data[data$Gene=='CDK6',]
SMAD2=data[data$Gene=='SMAD2',]
SMAD3=data[data$Gene=='SMAD3',]
CDK2=data[data$Gene=="CDK2",]
CCNE1=data[data$Gene=="CCNE1",]
CCNE2=data[data$Gene=="CCNE2",]



p1=ggplot(data=ccna1,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=ccna1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCNA1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p2=ggplot(data=CDK1,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CDK1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CDK1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p3=ggplot(data=CCNB1,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCNB1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCNB1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


p4=ggplot(data=UBE2C,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=UBE2C,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("UBE2C")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


p5=ggplot(data=AURKA,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=AURKA,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("AURKA")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p6=ggplot(data=CDT1,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CDT1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CDT1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p7=ggplot(data=GMNN,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=GMNN,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("GMNN")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p8=ggplot(data=CCND1,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCND1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCND1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p9=ggplot(data=CCND2,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCND2,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCND2")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p10=ggplot(data=CCND3,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCND3,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCND3")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p11=ggplot(data=CDK4,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CDK4,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CDK4")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p12=ggplot(data=CDK6,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CDK6,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CDK6")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p13=ggplot(data=SMAD2,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=SMAD2,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("SMAD2")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p14=ggplot(data=SMAD3,
          aes(x=Sample,
              y=Mean,
              group=DMSOvsControl,
              color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=SMAD3,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("SMAD3")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p15=ggplot(data=CDK2,
           aes(x=Sample,
               y=Mean,
               group=DMSOvsControl,
               color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CDK2,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CDK2")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p16=ggplot(data=CCNE1,
           aes(x=Sample,
               y=Mean,
               group=DMSOvsControl,
               color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCNE1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCNE1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p17=ggplot(data=CCNE2,
           aes(x=Sample,
               y=Mean,
               group=DMSOvsControl,
               color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=CCNE2,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("CCNE2")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


#source("~/helpers.R")
#multiplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,cols=3)




