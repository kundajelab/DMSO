library(gplots)
library(data.table)
data=data.frame(read.table('heatmap_inputs.stringent.txt',header=T,sep='\t'))
ylab=data$Gene
data$Gene=NULL
xlab=names(data)
nv=apply(abs(data),1,max)
subset_data=head(data[order(nv,decreasing=TRUE),],200)
#subset_data=data
x=as.matrix(subset_data)
png("top200stringentsignificantgenes.png",width=8,height=25,units="in",res=300)
heatmap.2(x,
          cexCol=1,
          keysize=0.5,
          margins=c(20,5),
          labRow=ylab,
          labCol=xlab,
          main="200 Genes with highest fold change, p-value of dif. exp < 0.001")
          #main="abs(log2FoldChange)>0.1,p-value <0.001")
          
dev.off()