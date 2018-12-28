rm(list=ls())
library(gplots)
data=read.table("homer.summary.filtered.csv",header=TRUE,sep='\t',row.names=1)
#svg('heatmap.svg',height=15,width=5)

hmcols<-colorRampPalette(c('#fff7fb','#ece7f2','#d0d1e6','#a6bddb','#74a9cf','#3690c0','#0570b0','#045a8d','#023858'))(10)
heatmap.2(as.matrix(data),
          col=hmcols,
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          cexCol = 1,
          dendrogram="none",
          sepwidth=c(0.01, 0.01),  # width of the borders
          sepcolor='black',  
          colsep=1:ncol(data),
          rowsep=1:nrow(data),
          margins=c(10,5))
#dev.off()
