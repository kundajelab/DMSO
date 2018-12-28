rm(list=ls())
library(ggplot2)
data=read.table("great.to.plot.csv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data$GO.Term=factor(data$GO.Term,levels=unique(data$GO.Term))
ggplot(data=data,
       aes(x=data$GO.Term,
           y=data$X.10log10.BH.,
           group=data$Sample,
           fill=data$Sample))+
  geom_bar(stat='identity',position = 'dodge')+
  coord_flip()+
  xlab("Pathway/GO Term\n enriched(GREAT)")+
  ylab("-10log10(BH-adjusted P-value)")+
  scale_fill_manual(name="Sample",values=c('#1b9e77','#d95f02','#7570b3','#e7298a','#66a61e','#e6ab02'))
