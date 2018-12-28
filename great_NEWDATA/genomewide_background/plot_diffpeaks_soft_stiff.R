rm(list=ls())
library(ggplot2)
data=read.table("diffpeaks_soft_v_stiff.csv",header=TRUE,sep='\t')
data=data[order(data$Value),]
data$Name=factor(data$Name,levels=data$Name)
ggplot(data=data,
       aes(x=data$Name,
           y=data$Value))+
  geom_bar(stat='identity')+
  coord_flip()+
  xlab("Pathway/GO Term\n enriched in Stiff vs Soft (GREAT)")+
  ylab("-10log10(BH-adjusted P-value)")
