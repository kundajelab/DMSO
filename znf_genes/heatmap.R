rm(list=ls())
library(gplots)

rna=read.table("znf.diff.genes.txt",header=TRUE,sep='\t')

rna_rownames=rna$Gene
rna$Gene=NULL
rna=as.matrix(rna)
png('ZNF differential genes',height=10,width=10,units='in',res=600)
heatmap.2(rna,
          cexCol=1,
          col=redgreen(30),
          Colv=TRUE,
          Rowv=TRUE,
          density.info="none",
          scale="none",
          trace="none",
          labRow=rna_rownames,
          margins=c(10,10),
          main="Differential ZNF genes")
dev.off() 

