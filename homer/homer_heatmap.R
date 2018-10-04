rm(list=ls())
library(gplots)
data=read.table("homer.summary",header=TRUE,sep='\t',row.names=1)
svg('heatmap.svg',height=15,width=5)

hmcols<-colorRampPalette(c("#67a9cf","#f7f7f7","#ef8a62"))(50)
heatmap.2(as.matrix(data),
          col=hmcols,
          Rowv=TRUE,
          Colv=TRUE,
          density.info="none",
          scale="none",
          trace="none",
          cexCol = 0.8,
          dendrogram="none",
          margins=c(10,5))
dev.off()
