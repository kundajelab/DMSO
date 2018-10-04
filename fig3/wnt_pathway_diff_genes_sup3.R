rm(list=ls())
library(gplots)
data=read.table('wnt_pathway_diff_genes_sup3.csv',header=TRUE,sep='\t',row.names = 1)
data=as.matrix(data)
hmcols<-colorRampPalette(c("blue","white","red"))(20)
#png('ATACSEQ_from_intersection.png',height=12,width=10,units='in',res=600)
#svg(filename="fig2d.svg",height=20,width=15)
heatmap.2(data,
          col=hmcols,
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="none",
          trace="none",
          dendrogram="none",
          sepwidth=c(0.01, 0.05),  # width of the borders
          sepcolor='black',  
          cexCol = 1,
          rowsep=seq(0,nrow(data)),
          colsep=seq(0,ncol(data)),
          margins=c(5,10),
          breaks=quantile(data,probs=seq(0,1,0.04))[5:25])
