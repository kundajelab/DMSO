rm(list=ls())
library(gplots)
atac=read.table("atac.hits",header=TRUE,sep='\t')
rna=read.table("rna.hits",header=TRUE,sep='\t')
chip=read.table("chip.hits",header=TRUE,sep='\t')


rna_rownames=rna$Gene
rna$Gene=NULL
rna=as.matrix(rna)
png('RNASEQ_methylation.png',height=15,width=10,units='in',res=300)
heatmap.2(rna,
          cexCol=1,
          col=redgreen(30),
          Colv=FALSE,
          Rowv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=rna_rownames,
          margins=c(10,10),
          keysize=0.5,
          main="RNASEQ methylation")
dev.off() 

atac_rownames=atac$Gene_Chrom_Start_End
atac$Gene_Chrom_Start_End=NULL
atac=as.matrix(atac)
png('ATACSEQ_methylation.png',height=10,width=10,units='in',res=600)
heatmap.2(atac,
          cexCol=1,
          Colv=FALSE,
          Rowv=FALSE,
          col=redgreen(30),
          density.info="none",
          scale="row",
          trace="none",
          labRow=atac_rownames,
          margins=c(10,15),
          main="ATACSEQ methylation")
dev.off()


chip_rownames=chip$Gene_Chrom_Start_End
chip$Gene_Chrom_Start_End=NULL
chip=as.matrix(chip)
png('CHIPSEQ_methylation.png',height=10,width=10,units='in',res=600)
heatmap.2(chip,
          cexCol=1,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=chip_rownames,
          margins=c(10,15),
          keysize = 0.5,
          main="CHIPSEQ methylation")
dev.off()
