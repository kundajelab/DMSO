rm(list=ls())
library(gplots)
atac=read.table("peaks_to_plot.earlyG1.down.csv",header=TRUE,sep='\t')
rna=read.table("genes_to_plot.earlyG1.down.csv",header=TRUE,sep='\t')

atac_rownames=atac$Peak
atac$Peak=NULL
atac=as.matrix(atac)
png('peak.png')
heatmap.2(atac,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          dendrogram = "none",
          scale="row",
          trace="none",
          labRow=atac_rownames,
          margins=c(10,10))
dev.off() 

rna_rownames=rna$Gene
rna$Gene=NULL
rna=as.matrix(rna)
png('gene.png')
heatmap.2(rna,
          col=redgreen(30),
          Colv=FALSE,
          Rowv=TRUE,
          density.info="none",
          dendrogram="none",
          scale="row",
          trace="none",
          labRow=rna_rownames,
          margins=c(10,10))
dev.off() 
