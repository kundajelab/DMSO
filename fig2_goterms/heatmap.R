rm(list=ls())
library(ggplot2)
library(made4)

#data=read.table("GO0000075.diff.txt",header=TRUE,sep='\t',row.names=1)
#data=read.table("GO00006936.diff.txt",header=TRUE,sep='\t',row.names=1)
#data=read.table("GO0004714.diff.txt",header=TRUE,sep='\t',row.names=1)
#data=read.table("GO0007050.diff.txt",header=TRUE,sep='\t',row.names=1)
data=read.table("GO0042127.diff.txt",header=TRUE,sep='\t',row.names=1)
#data=read.table("GO0045786.diff.txt",header=TRUE,sep='\t',row.names=1)
#data=read.table("GO1901976.diff.txt",header=TRUE,sep='\t',row.names=1)
data=data[apply(data,1,max)> 1,]
earlyG1=data[,4]/data[,1]
lateG1=data[,5]/data[,2]
SG2M=data[,6]/data[,3]
data2=data.frame(earlyG1,lateG1,SG2M)
data2[is.na(data2)]=0
data2[data2==Inf]=0
rownames(data2)=rownames(data)
data2=data2[rowSums(data2)>0,]
data2=data2[apply(data2,1,max)> 2,]
svg("GO0042127.svg",height=20,width=3,pointsize=12)
heatplot(data2,dend="row",zlim=c(-5,5),cols.default = TRUE,cexCol=0.1,scaleKey=FALSE)
dev.off() 

#hmcols<-colorRampPalette(c("#91bfdb","#ffffbf","#fc8d59"),interpolate="spline")(46)
# distCor <- function(x) as.dist(1-cor(t(x)))
# hclustAvg <- function(x) hclust(x, method="average")
# heatmap.2(as.matrix(data2),
#           col=hmcols,
#           Rowv=TRUE,
#           Colv=TRUE,
#           density.info="none",
#           trace="none",
#           scale="row",
#           dendrogram="none",
#           distfun = distCor,
#           hclustfun=hclustAvg,
#           symbreaks=FALSE,
#           breaks=quantile(as.matrix(data2),probs=seq(0,1,0.02))[5:51],
#           cexCol=1)