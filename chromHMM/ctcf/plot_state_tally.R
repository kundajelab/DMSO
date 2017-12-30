rm(list=ls())
data=read.table("ctcf_all_states.tally.txt",header=TRUE,sep='\t')
data$State=factor(data$State,levels=data$State) 
colors=read.table("ctcf_state_map.txt",header=FALSE,sep='\t')
colors$V2=colors$V2/255
colors$V3=colors$V3/255
colors$V4=colors$V4/255
#colors=colors[c(1,2,4,5,7,8,9,10,13,14,15),]
library(ggplot2)
library(reshape2)
melted=melt(data)
cbbPalette = rgb(colors$V2,colors$V3,colors$V4)
p1=ggplot(data=melted,aes(x=variable,y=value,group=State,fill=State))+
  geom_bar(stat="identity")+
  theme_bw(20)+
  ggtitle("10-factor Chromatin State Distribution for Differential ATAC-seq Peaks")+
  xlab("Differentially Accessible Peak Response to DMSO treatment")+
  ylab("Number of Peaks")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_fill_manual(values=cbbPalette)

data[,2:ncol(data)]=t(t(data[,2:ncol(data)])/colSums(data[,2:ncol(data)]))
#data[,2]=t(t(data[,2])/sum(data[,2]))
melted=melt(data)
cbbPalette = rgb(colors$V2,colors$V3,colors$V4)
p2=ggplot(data=melted,aes(x=variable,y=value,group=State,fill=State))+
  geom_bar(stat="identity")+
  theme_bw(20)+
  ggtitle("10-factor Chromatin State Distribution for Differential ATAC-seq Peaks")+
  xlab("Differentially Accessible Peak Response to DMSO treatment")+
  ylab("Fraction of of Peaks")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_fill_manual(values=cbbPalette)
