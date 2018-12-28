rm(list=ls())
library(ggplot2)
library(stringr)
data=read.table("barchart_inputs.csv",header=TRUE,sep='\t',stringsAsFactors = FALSE)
data$Cluster=factor(data$Cluster,levels=unique(data$Cluster))
data$Term=str_wrap(data$Term,width=30)
data$Term=factor(data$Term,levels=unique(data$Term))
p1=ggplot(data=data,
          aes(x=data$Term,
              y=data$X.10log10.Pvalue.,
              fill=data$Cluster))+
  geom_bar(stat="identity",position="dodge")+
  scale_fill_manual(name="Cluster",values=c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6','#6a3d9a'))+
  xlab("MSIGDB")+
  ylab("-10log10(FDR)")+
  coord_flip()+
  theme_bw(20)
print(p1)
svg("barchart.svg",height=15,width=10)
print(p1)
dev.off() 

