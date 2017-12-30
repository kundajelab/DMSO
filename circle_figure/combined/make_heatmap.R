rm(list=ls())
library(gplots)
atac=read.table("all.combined.heatmap.txt",header=TRUE,sep='\t')
atac_rownames=atac$Gene.Time
atac$Gene.Time=NULL
atac=as.matrix(atac)
rownames(atac)=atac_rownames
png('heatmap.png',height=30,width=10,units='in',res=600)
heatmap.2(atac,
          cexCol=1,
          col=redblue(3),
          Rowv=TRUE,
          Colv=TRUE,
          density.info="none",
          scale="none",
          trace="none",
          margins=c(15,15),
          keysize = 0.5,
          main="Significant Genes And Pathways")
dev.off()

