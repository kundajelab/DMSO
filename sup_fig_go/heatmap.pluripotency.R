rm(list=ls())
data=read.table("rsem.pluripotency.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
genes=data$Gene
data$Gene=NULL
data=asinh(data)
data=as.matrix(data)
library(gplots)
heatmap.2(data,
          Rowv=TRUE,
          Colv=TRUE,
          col=bluered(50),
          symbreaks=FALSE,
          dendrogram = "none",
          main="Pluripotency Genes (GO:0019827)",
          labRow="",
          density.info = "none",
          trace="none",
          scale="none",
          margins=c(10,5))