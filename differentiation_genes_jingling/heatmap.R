rm(list=ls())
library(gplots)
atac=read.table("atac.hits",header=TRUE,sep='\t')
rna=read.table("rna.hits",header=TRUE,sep='\t')
chip=read.table("chip.hits",header=TRUE,sep='\t')


rna_rownames=rna$Gene
rna$Gene=NULL
rna=as.matrix(rna)
png('RNASEQ_differentiation.png',height=10,width=10,units='in',res=300)
a=heatmap.2(rna,
          cexCol=1,
          col=redgreen(30),
          Colv=FALSE,
          Rowv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=rna_rownames,
          margins=c(10,10),
          main="RNASEQ differentiation")
dev.off() 

atac_rownames=atac$Gene_Chrom_Start_End
atac$Gene_Chrom_Start_End=NULL
atac=as.matrix(atac)
png('ATACSEQ_differentiation.png',height=20,width=10,units='in',res=600)
heatmap.2(atac,
          cexCol=1,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=atac_rownames,
          margins=c(15,15),
          keysize = 0.5,
          main="ATACSEQ differentiation")
dev.off()


chip_rownames=chip$Gene_Chrom_Start_End
chip$Gene_Chrom_Start_End=NULL
chip=as.matrix(chip)
png('CHIPSEQ_differentiation.png',height=17,width=10,units='in',res=600)
heatmap.2(chip,
          cexCol=1,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=chip_rownames,
          margins=c(15,15),
          keysize = 0.5,
          main="CHIPSEQ differentiation")
dev.off()
