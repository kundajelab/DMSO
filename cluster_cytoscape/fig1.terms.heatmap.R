rm(list=ls())
library(ggplot2)
library(gplots)
data=read.table("fig1.enriched.pathways.cleaned.txt",header=TRUE,row.names=1,sep='\t')
data=-log10(data)
data[is.na(data)]=0
colors=colorRampPalette(c('#fff7f3','#fde0dd','#fcc5c0','#fa9fb5','#f768a1','#dd3497','#ae017e','#7a0177','#49006a'))(100)
#heatmap.2(x=as.matrix(t(data)),
#          col=colors,
#          scale='none',
#          trace='none',
#          Colv = TRUE,
#          Rowv=FALSE,
#          keysize=0.5,
#          margins=c(20,5))
heatmap.2(x=as.matrix(t(data)),
          col=colors,
          scale='none',
          trace='none',
          Colv = TRUE,
          Rowv=FALSE)
