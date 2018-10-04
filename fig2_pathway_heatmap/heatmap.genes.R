rm(list=ls())
library(gplots)
data=read.table('pathways.rnaseq.csv',header=TRUE,sep='\t')
#data=read.table('pathways.atacseq.dist.andprox.csv',header=TRUE,sep='\t')
data[is.na(data)]=0
data$sample=gsub("\\.", " ",data$sample) 
data$sample=gsub("\\_", " ",data$sample) 

names(data)=gsub("\\."," ",names(data))
data_rownames=data$sample

data$sample=NULL
labCol2=names(data)

data=as.matrix(data)
#data=-10*log10(data)
#data[is.infinite(data)]=0
hmcols<-colorRampPalette(c("#deebf7","#9ecae1","#3182bd"))(50)
#png('ATACSEQ_from_intersection.png',height=12,width=10,units='in',res=600)
#svg(filename="fig2d.svg",height=20,width=15)
heatmap.2(data,
          col=hmcols,
          Rowv=TRUE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          dendrogram="none",
          labRow=data_rownames,
          margins=c(10,25),
          sepwidth=c(0.05, 0.05),  # width of the borders
          sepcolor='black',  
          rowsep=seq(0,nrow(data)),
          colsep=c(0,3,6),
          cexCol=1)
#dev.off()
#          keysize=0.1)
#dev.off() 
