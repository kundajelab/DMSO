rm(list=ls())
library(gplots)
atac=read.table("r_atac_input.csv",header=TRUE,sep='\t')
rna=read.table("r_rna_input.csv",header=TRUE,sep='\t')
chip=read.table("r_chip_input.csv",header=TRUE,sep='\t')

atac_rownames=atac$GREAT.Gene.Map
atac$GREAT.Gene.Map=NULL
atac=as.matrix(atac)
png('ATACSEQ_from_intersection.png',height=12,width=10,units='in',res=600)
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
          main="ATACSEQ peaks from 3-way intersection")
dev.off() 

rna_rownames=rna$GREAT.Gene.Map
rna$GREAT.Gene.Map=NULL
rna=as.matrix(rna)
png('RNASEQ_from_intersection.png',height=10,width=10,units='in',res=600)
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
          main="RNASEQ peaks from 3-way intersection")
dev.off() 


chip_rownames=chip$GREAT.Gene.Map
chip$GREAT.Gene.Map=NULL
chip=as.matrix(chip)
png('CHIPSEQ_from_intersection.png',height=17,width=10,units='in',res=600)
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
          main="CHIPSEQ peaks from 3-way intersection")
dev.off() 
