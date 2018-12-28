rm(list=ls())
library(ggplot2)
library(reshape2)
library(stringr)

#data=read.table("cell_cycle.tsv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data=read.table("oxidative_stress_response.tsv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data$GeneSet=str_wrap(data$GeneSet,width=30)
data=melt(data)
data$variable=factor(data$variable,levels=unique(data$variable))
ggplot(data=data,
       aes(x=data$GeneSet,
           y=data$value,
           fill=data$variable))+
  geom_bar(stat="identity",position="dodge")+
  xlab("GO Term (BP)")+
  ylab("-10log10(Pvalue)")+
  coord_flip()+
  ylim(-100,100)+
  scale_fill_manual(name="Cell Cycle Phase",values=c('#1b9e77','#d95f02','#7570b3'))