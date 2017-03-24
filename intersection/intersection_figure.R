rm(list=ls())
library(gplots)
atac=read.table("atac.hits.sparse",header=TRUE,sep='\t')
rna=read.table("rna.hits",header=TRUE,sep='\t')
chip=read.table("chip.hits.sparse",header=TRUE,sep='\t')


rna_rownames=rna$Gene
rna$Gene=NULL
rna=as.matrix(rna)
a=heatmap.2(rna,
            cexCol=1,
            col=redgreen(30),
            Colv=FALSE,
            Rowv=FALSE,
            density.info="none",
            scale="row",
            trace="none",
            labRow=rna_rownames,
            dendrogram="none",
            keysize=0.2,
            margins=c(10,10),
            main="RNASEQ differentiation")

atac_rownames=atac$Gene_Chrom_Start_End
atac$Gene_Chrom_Start_End=NULL
atac=as.matrix(atac)
heatmap.2(atac,
          cexCol=1,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=atac_rownames,
          dendrogram="none",
          keysize=0.2,
          margins=c(10,10),
          main="ATACSEQ differentiation")

chip_rownames=chip$Gene_Chrom_Start_End
chip$Gene_Chrom_Start_End=NULL
chip=as.matrix(chip)
heatmap.2(chip,
          cexCol=1,
          col=redgreen(30),
          Rowv=FALSE,
          Colv=FALSE,
          density.info="none",
          scale="row",
          trace="none",
          labRow=chip_rownames,
          dendrogram="none",
          keysize=0.2,
          margins=c(10,10),
          main="CHIPSEQ differentiation")
