rm(list=ls())
library(gplots)
data=read.table('pathways.atacseq.dist.andprox.csv',header=TRUE,sep='\t',row.names=1)
#data$sample=gsub("\\.", " ",data$sample) 
#data$sample=gsub("\\_", " ",data$sample) 

#names(data)=gsub("\\."," ",names(data))
#data_rownames=data$sample

#data$sample=NULL
#labCol2=names(data)

data=as.matrix(data)
data[is.na(data)]=0
data=data[rowSums(data)>0,]
#data=-10*log10(data)
#data[is.infinite(data)]=0
hmcols<-colorRampPalette(c("white","blue"))(50)
#png('ATACSEQ_from_intersection.png',height=12,width=10,units='in',res=600)
heatmap.2(data,
          col=hmcols,
          Rowv=TRUE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          dendrogram="none",
          cexCol = 0.9,
          rowsep = seq(0,nrow(data)),
          colsep=seq(0,ncol(data)),
          sepcolor = "black",
          margins=c(10,25),
          keysize=0.1)
#dev.off() 
