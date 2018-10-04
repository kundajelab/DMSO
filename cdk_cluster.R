data=read.table("cdk.csv",header=TRUE,sep='\t')
gene=data$Gene
data$Gene=NULL
data=as.matrix(data)

rownames(data)=gene
library(gplots)
heatmap.2(data,
          Rowv=TRUE,
          Colv=TRUE,
          col=bluered(50),
          symbreaks=FALSE,
          dendrogram = "none",
          main="Regulation of Cell Cycle Checkpoint (GO:1901976)",
          density.info = "none",
          trace="none",
          scale="none",
          colsep=seq(0,ncol(data)),
          rowsep=c(0,nrow(data)),
          sepwidth = c(0.01,0.05),
          sepcolor = "black",
          margins=c(10,10))
