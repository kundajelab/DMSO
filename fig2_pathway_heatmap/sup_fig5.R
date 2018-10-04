rm(list=ls())
library(gplots)
data=read.table('pathways.csv',header=TRUE,sep='\t')
data$sample=gsub("\\.", " ",data$sample) 
data$sample=gsub("\\_", " ",data$sample) 

names(data)=gsub("\\."," ",names(data))
data_rownames=data$sample

data$sample=NULL
labCol2=names(data)

data=as.matrix(data)
#data=-10*log10(data)
#data[is.infinite(data)]=0
hmcols<-colorRampPalette(c("white","blue"))(50)
#png('ATACSEQ_from_intersection.png',height=12,width=10,units='in',res=600)
heatmap.2(data,
          col=hmcols,
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          dendrogram="none",
          labRow=data_rownames,
          labCol="",
          margins=c(10,25),
          add.expr = text(x = seq_along(labCol2)-1, y =-0.2, srt = 30,
                          labels = labCol2, xpd = TRUE))
#dev.off() 
