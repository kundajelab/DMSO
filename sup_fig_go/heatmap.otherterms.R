rm(list=ls())
data=read.table("GO1901976.rsem.tpm.averaged.filtered.reps.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
genes=data$Gene
data$Gene=NULL
data=asinh(data)
data=as.matrix(data)
rownames(data)=genes
library(gplots)
svg(filename="GO1901976.svg",width=3)
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
          margins=c(10,5))
dev.off() 
#rm(list=ls())
data=read.table("GO0000075.rsem.tpm.averaged.filtered.reps.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
genes=data$Gene
data$Gene=NULL
data=asinh(data)
data=as.matrix(data)
#rownames(data)=genes
library(gplots)
svg(filename="GO0000075.svg",width=3)
heatmap.2(data,
          Rowv=TRUE,
          Colv=TRUE,
          col=bluered(50),
          symbreaks=FALSE,
          dendrogram = "none",
          main="Cell Cycle Checkpoint (GO:0000075)",
          density.info = "none",
          labRow="",
          trace="none",
          scale="none",
          colsep=seq(0,ncol(data)),
          rowsep=c(0,nrow(data)),
          sepwidth = c(0.01,0.05),
          sepcolor = "black",
          margins=c(10,5))
dev.off() 

#rm(list=ls())
data=read.table("GO0045786.rsem.tpm.averaged.filtered.reps.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
genes=data$Gene
data$Gene=NULL
data=asinh(data)
data=as.matrix(data)
#rownames(data)=genes
library(gplots)
svg(filename="GO0045786.svg",width=3)
heatmap.2(data,
          Rowv=TRUE,
          Colv=TRUE,
          col=bluered(50),
          symbreaks=FALSE,
          dendrogram = "none",
          main="Negative Regulation of Cell Cycle (GO:0045786)",
          density.info = "none",
          labRow="",
          trace="none",
          scale="none",
          colsep=seq(0,ncol(data)),
          rowsep=c(0,nrow(data)),
          sepwidth = c(0.01,0.05),
          sepcolor = "black",
          margins=c(10,5))
dev.off() 

#rm(list=ls())
data=read.table("GO0007050.rsem.tpm.averaged.filtered.reps.txt",header=TRUE,sep='\t',stringsAsFactors = FALSE)
genes=data$Gene
data$Gene=NULL
data=asinh(data)
data=as.matrix(data)
rownames(data)=NULL
library(gplots)
svg(filename="GO0007050.svg",width=3)
heatmap.2(data,
          Rowv=TRUE,
          Colv=TRUE,
          col=bluered(50),
          symbreaks=FALSE,
          dendrogram = "none",
          main="Cell Cycle Arrest (GO:0007050)",
          density.info = "none",
          trace="none",
          scale="none",
          colsep=seq(0,ncol(data)),
          rowsep=c(0,nrow(data)),
          sepwidth = c(0.01,0.05),
          sepcolor = "black",
          labRow = "",
          margins=c(10,5))
dev.off() 
