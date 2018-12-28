rm(list=ls())
library(ggplot2)
library(reshape2)
data=read.table("all.rsem.transposed.txt",header=TRUE,sep='\t',stringsAsFactors=FALSE)
genes=unique(data$Gene)

for(gene in genes){
  subset=data[data$Gene==gene,]
  subset$State=factor(subset$State,levels=subset$State)
  p1=ggplot(data=subset,
            aes(x=subset$State,
                y=subset$Mean))+
    geom_bar(stat='identity')+
    geom_errorbar(data=subset,aes(x=subset$State,ymin=subset$Mean-subset$SD,ymax=subset$Mean+subset$SD))+
    ggtitle(gene)+
    theme_bw(20)+
    ylab("")+
    xlab("")+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
  svg(paste(gene,'.svg'),height=3,width=3)
  print(p1)
  dev.off() 
}