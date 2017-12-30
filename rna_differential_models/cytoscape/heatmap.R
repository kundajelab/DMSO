rm(list=ls())
data=read.table('pathways.txt',header=TRUE,sep='\t',row.names=1)
library(gplots)
my_palette <- colorRampPalette(c("white","blue"))(n = 30)
png("heatmap.pathways.png",width=8,height=11,units='in',res=300)
heatmap.2(x=as.matrix(data),
          margins=c(10,30),
          Colv=NULL,
          dendrogram = "none",
          trace="both",
          tracecol = "black",
          vline=NULL,
          hline=NULL,
          main="-10*log(FDR)\nPathways Affected by DMSO Treatment",
          col=my_palette,
          cexCol=0.8)
dev.off()