rm(list=ls())
data=read.table("all_states.tally.txt",header=TRUE,sep='\t')
colors=read.table("state_map.txt",header=FALSE,sep='\t')
colors$V2=NULL
colors$V3=as.numeric(colors$V3)/255
colors$V4=as.numeric(colors$V4)/255
colors$V5=as.numeric(colors$V5)/255
#colors=colors[c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)]
library(ggplot2)
library(reshape2)
melted=melt(data)
cbbPalette = rgb(colors$V3,colors$V4,colors$V5)
p1=ggplot(data=melted,aes(x=variable,y=value,group=State,fill=State))+
  geom_bar(stat="identity")+
  theme_bw(20)+
  ggtitle("Chromatin State Distribution for Differential ATAC-seq Peaks")+
  xlab("Differentially Accessible Peak Response to DMSO treatment")+
  ylab("Number of Peaks")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_fill_manual(values=cbbPalette)

data[,2:ncol(data)]=t(t(data[,2:ncol(data)])/colSums(data[,2:ncol(data)]))
melted=melt(data)
p2=ggplot(data=melted,aes(x=variable,y=value,group=State,fill=State))+
  geom_bar(stat="identity")+
  theme_bw(20)+
  ggtitle("Chromatin State Distribution for Differential ATAC-seq Peaks")+
  xlab("Differentially Accessible Peak Response to DMSO treatment")+
  ylab("Fraction of of Peaks")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_fill_manual(values=cbbPalette)
