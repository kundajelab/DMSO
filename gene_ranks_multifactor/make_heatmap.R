rm(list=ls())
library(gplots)
library(data.table)
#data=data.frame(read.table('shown-geneFamilies.tsv.heatmap',header=TRUE,sep='\t'))
#data=data.frame(read.table('shown-GOMolecularFunction.tsv.heatmap',header=TRUE,sep='\t'))
#data=data.frame(read.table('shown-interpro.tsv.heatmap',header=TRUE,sep='\t'))
#data=data.frame(read.table('shown-MGIExpressionDetected.tsv.heatmap',header=TRUE,sep='\t'))
#data=data.frame(read.table('shown-MSigDBGeneSetsCanonicalPathway.tsv.heatmap',header=TRUE,sep='\t'))
#data=data.frame(read.table('shown-MSigDBGeneSetsPromoterMotifs.tsv.heatmap',header=TRUE,sep='\t'))
data=data.frame(read.table('shown-treefam.tsv.heatmap',header=TRUE,sep='\t'))
#ylab=data$geneFamilies; 
#ylab=data$GOMolecularFunction;
#ylab=data$interpro
#ylab=data$MGIExpressionDetected
#ylab=data$MSigDBGeneSetsCanonicalPathway
#ylab=data$MSigDBGeneSetsPromoterMotifs
ylab=data$treefam
xlab=names(data)
#data$geneFamilies=NULL; 
#data$GOMolecularFunction=NULL; 
#data$interpro=NULL
#data$MGIExpressionDetected=NULL; 
#data$MSigDBGeneSetsCanonicalPathway=NULL; 
#data$MSigDBGeneSetsPromoterMotifs=NULL;
data$treefam=NULL;
data=as.matrix(data)
heatmap.2(data,
          Rowv=FALSE,
          Colv=FALSE,
          colsep=c(9),
          #col=bluered(15),
          col=bluered(200),
          symbreaks=FALSE,
          #breaks=c(0,5,10,15,20,25,30,35, 40, 45,50,60,75,100,150,200),
          #main="Gene Families (GREAT) -10log10(FDR)",
          #main="GO Molecular Function\n(GREAT)\n-10log10(FDR)",
          #main="Interpro\n(GREAT)\n-10log10(FDR)",
          #main="MGIExpressionDetected\n(GREAT)\n-10log10(FDR)",
          #main="CanonicalPathways\n(GREAT)\n-10log10(FDR)",
          #main="MSigDBGeneSetPromoterMotifs",
          main="TreeFam\n(GREAT)\n-10log10(FDR)",
          labCol = c("Upregulated\nw/DMSO","Downregulated\nw/ DMSO"),
          labRow=ylab,
          #ylab="Gene Family",
          #ylab="GO Molecular Function",
          #ylab="Interpro Term",
          #ylab="MGIExpressionDetecgted",
          #ylab="MSigDBGeneSetsCanonicalPathways",
          #ylab="MsigDBGeneSetPromoterMotifs",
          ylab="TreeFam",
          xlab="Condition",
          cexCol = 1,
          margins=c(10,20))
