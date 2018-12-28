rm(list=ls())
library(gplots)
source("~/helpers.R")
# data1=read.table("1.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data2=read.table("2.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data3=read.table("3.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data4=read.table("4.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data5=read.table("5.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data6=read.table("6.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data7=read.table("7.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data8=read.table("8.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data9=read.table("9.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)
# data10=read.table("10.fold_change_cpm",header=TRUE,sep='\t',row.names = 1)

data=read.table('1.fold_change_cpm',header=TRUE,sep='\t',row.names = 1)
#data$Chrom=NULL
#data$Start=NULL
#data$End=NULL
#data$Gene=NULL
#earlyG1=data[,4]/data[,1]
#lateG1=data[,5]/data[,2]
#SG2M=data[,6]/data[,3]
#data=data.frame(earlyG1,lateG1,SG2M)
#names(data)=c("earlyG1","lateG1","SG2M")
#data[data==Inf]=NA
#data=na.omit(data)

hmcols<-colorRampPalette(c("#91bfdb","#ffffbf","#fc8d59"))(50)
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
