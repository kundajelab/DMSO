rm(list=ls())
data=read.table("pi3k.fc.tsv",header=TRUE,row.names = 1)
data=log2(data)
library(gplots)
hmcols<-colorRampPalette(c("#91bfdb","#ffffbf","#fc8d59"))(50)

h=heatmap.2(as.matrix(data),
          col=hmcols,
          Rowv=TRUE,
          Colv=FALSE,
          distfun=function(x) dist(x,method="euclidean"),
          hclustfun=function(x) hclust(x, method="ward.D"),
          density.info="none",
          scale="row",
          trace="none",
          dendrogram="none",
          cexCol=0.8,
          cexRow=0.8)
data=as.data.frame(t(h$carpet))
heatmap.2(as.matrix(data),
          col=hmcols,
          Rowv=TRUE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          dendrogram="none",
          cexCol=0.8,
          cexRow=0.8,
          keysize = 0.1)