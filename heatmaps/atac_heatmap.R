rm(list=ls())
library(gplots)
library(preprocessCore)
library(DESeq2)
require(gtools)
require(RColorBrewer)
library(cba)
library(limma)
cols <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
inputf="normcounts_from_deseq.diff.txt"
data=read.table(inputf,header=TRUE,sep='\t',stringsAsFactors = FALSE,row.names = 1)
data=as.matrix(data)


#We split the fold change matrix into 1% quantiles 
quantile.range <- quantile(data, probs = seq(0, 1, 0.01))
#we scale the breaks in the heatmap color palette according to the quantiles. 
palette.breaks <- seq(quantile.range["5%"], quantile.range["95%"], 0.1)

# 
# heatmap.2(data,
#           scale     = "none",
#           col       = rev(colorRampPalette(brewer.pal(10, "RdBu"))(length(palette.breaks) - 1)),
#           distfun   = function(x) dist(x,method="euclidean"),
#           hclustfun = function(x) hclust(x, method="ward.D"),
#           Rowv=TRUE,
#           Colv=FALSE,
#           trace="none",
#           cexCol = 0.9,
#           margins=c(15,5),
#           breaks = palette.breaks,
#           labRow="")

#compute row z-scores 

zscores=t(apply(data,1,scale))
zdist=dist(zscores,method='euclidean')
zdist_clustered=hclust(zdist,method="ward.D")
ordered=order.optimal(zdist,zdist_clustered$merge)
sorted=zscores[ordered$order,]
colnames(sorted)=colnames(data)
rownames(sorted)=rownames(data)
quantile.range <- quantile(sorted, probs = seq(0, 1, 0.01))
#we scale the breaks in the heatmap color palette according to the quantiles. 
palette.breaks <- seq(quantile.range["5%"], quantile.range["95%"], 0.1)
svg("dmso_heatmap.svg")
heatmap.2(sorted,
          scale     = "none",
          col       = rev(colorRampPalette(brewer.pal(10, "RdBu"))(length(palette.breaks) - 1)),
          Rowv=FALSE,
          Colv=FALSE,
          trace="none",
          cexCol = 0.9,
          margins=c(15,5),
          labRow="",
          breaks = palette.breaks)
dev.off()