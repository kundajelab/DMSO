rm(list=ls())
library(ggplot2)
library(reshape2)
data=read.table("toplot.formatted.line.csv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data$DMSOvsControl=factor(data$DMSOvsControl)

pgam1=data[data$Gene=='PGAM1',]
#pgam1$Sample=factor(pgam1$Sample,levels=pgam1$Sample)

ndufa8=data[data$Gene=='NDUFA8',]
#ndufa8$Sample=factor(ndufa8$Sample,levels=ndufa8$Sample)

lefty2=data[data$Gene=='LEFTY2',]
#lefty2$Sample=factor(lefty2$Sample,levels=lefty2$Sample)

itsn1=data[data$Gene=='ITSN1',]
#itsn1$Sample=factor(itsn1$Sample,levels=itsn1$Sample)

wnt3=data[data$Gene=='WNT3',]
#wnt3$Sample=factor(wnt3$Sample,levels=wnt3$Sample)

pik3r3=data[data$Gene=='PIK3R3',]
#pik3r3$Sample=factor(pik3r3$Sample,levels=pik3r3$Sample)

egf=data[data$Gene=='EGF',]
#egf$Sample=factor(egf$Sample,levels=egf$Sample)

vim=data[data$Gene=='VIM',]
#vim$Sample=factor(vim$Sample,levels=vim$Sample)

lefty1=data[data$Gene=='LEFTY1',]
#lefty1$Sample=factor(lefty1$Sample,levels=lefty1$Sample)

polr2h=data[data$Gene=='POLR2H',]
#polr2h$Sample=factor(polr2h$Sample,levels=polr2h$Sample)

p1=ggplot(data=pgam1,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=pgam1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=.2,alpha=0.5)+
  ggtitle("PGAM1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p2=ggplot(data=ndufa8,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=ndufa8,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("NDUFA8")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


p3=ggplot(data=lefty2,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=lefty2,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("LEFTY2")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+	
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p4=ggplot(data=itsn1,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=itsn1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("ITSN1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+		
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p5=ggplot(data=wnt3,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=wnt3,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("WNT3")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


p6=ggplot(data=pik3r3,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=pik3r3,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("PIK3R3")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")


p7=ggplot(data=egf,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=egf,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("EGF")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p8=ggplot(data=vim,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=vim,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("VIM")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+	
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p9=ggplot(data=lefty1,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=lefty1,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD),width=0.2,alpha=0.5)+
  ggtitle("LEFTY1")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+		
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

p10=ggplot(data=polr2h,
          aes(x=Sample,
              y=Mean,
	      group=DMSOvsControl,
	      color=DMSOvsControl))+
  geom_line()+
  geom_point()+
  geom_errorbar(data=polr2h,aes(x=Sample,ymin=Mean-SD,ymax=Mean+SD))+
  ggtitle("POLR2H")+
  theme_bw(20)+
  ylab("TPM")+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+		
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  theme(legend.position="none")

source("~/helpers.R")
multiplot(p1,p6,p2,p7,p3,p8,p4,p9,p5,p10,cols=5)




