rm(list=ls())
library(gplots)
data=read.table('6.tpm',header=TRUE,sep='\t')
data$Chrom=NULL
data$Start=NULL
data$End=NULL
data$Gene=NULL
earlyG1=data[,4]/data[,1]
lateG1=data[,5]/data[,2]
SG2M=data[,6]/data[,3]
data=data.frame(earlyG1,lateG1,SG2M)
names(data)=c("earlyG1","lateG1","SG2M")
data[data==Inf]=NA
data=na.omit(data)

hmcols<-colorRampPalette(c("#67a9cf","#f7f7f7","#ef8a62"))(50)
heatmap.2(as.matrix(data),
          col=hmcols,
          Rowv=TRUE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow = "",
          cexCol = 0.8,
          dendrogram="none")
#dev.off() 
