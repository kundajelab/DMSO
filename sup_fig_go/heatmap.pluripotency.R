rm(list=ls())
data=read.table("pluripotency.rsem.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE,row.names = 1)
library(gplots)
data$earlyG1=data$earlyG1.DMSO/data$earlyG1.control
data$lateG1=data$lateG1.DMSO/data$lateG1.control
data$SG2M=data$SG2M.DMSO/data$SG2M.control
data$earlyG1.DMSO=NULL
data$earlyG1.control=NULL
data$lateG1.DMSO=NULL
data$lateG1.control=NULL
data$SG2M.control=NULL
data$SG2M.DMSO=NULL
data=as.matrix(data)
data[data>5]=5
data[data< -5]=-5
hmcols<-colorRampPalette(c("#91bfdb","#ffffbf","#fc8d59"))(50)
svg("tmp.svg",height=20,width=5)
h=heatmap.2(as.matrix(data),
            col=hmcols,
            Rowv=TRUE,
            Colv=FALSE,
            distfun=function(x) dist(x,method="euclidean"),
            hclustfun=function(x) hclust(x, method="ward.D"),
            density.info="none",
            scale="none",
            trace="none",
            dendrogram="none",
            cexCol=0.8,
            cexRow=0.8,
            main="Pluripotency Genes (GO:0019827)")
dev.off() 