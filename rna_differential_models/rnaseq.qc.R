rm(list=ls())
library(limma)
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)

#RAW RSEM COUNTS FOR INDIVIDUAL REPLICATES! 
data=data.frame(read.table('rsem.expected_count.tsv',header=TRUE,sep='\t'))

#keep track of the gene names in a variable 
unique_names=data$Gene
rownames(data)=unique_names
data$Gene=NULL


#remove any genes that have all 0  counts 
all_zero_indices=which(rowSums(data)==0)
data=data[-all_zero_indices,]
data=as.matrix(data)

batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
#pc1 is weird -- no correspondence to DMSO vs Control or Timepoint , need to perform SVA

mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

#svaseq -- svaseq must be used with non-normalized data 
sva.obj=svaseq(data,mod1,mod0)
sva.obj=data.frame(sva.obj$sv)
colnames(sva.obj)=c("sva1")
sva.obj$exp_sv=exp(sva.obj$sva1)
batches$sva1=sva.obj$sva1
batches$exp_sva=sva.obj$exp_sv
#add in surrogate variables into the model matrix 
mod2=model.matrix(~0+Sample+sva1,data=batches)
mod3=model.matrix(~0+Sample+exp_sva,data=batches)
#specify the contrasts 
cont.matrix=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                          lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                          sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                          lateg1_earlyg1_dmso="Samplet.lateG1-Samplet.earlyG1",
                          sg2m_lateg1_dmso="Samplet.SG2M-Samplet.lateG1",
                          earlyg1_sg2m_dmso="Samplet.earlyG1-Samplet.SG2M",
                          lateg1_earlyg1_control="Samplec.lateG1-Samplec.earlyG1",
                          sg2m_lateg1_control="Samplec.SG2M-Samplec.lateG1",
                          earlyg1_sg2m_control="Samplec.earlyG1-Samplec.SG2M",
                          levels=mod2)

cont.matrix_exp=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                              lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                              sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                              lateg1_earlyg1_dmso="Samplet.lateG1-Samplet.earlyG1",
                              sg2m_lateg1_dmso="Samplet.SG2M-Samplet.lateG1",
                              earlyg1_sg2m_dmso="Samplet.earlyG1-Samplet.SG2M",
                              lateg1_earlyg1_control="Samplec.lateG1-Samplec.earlyG1",
                              sg2m_lateg1_control="Samplec.SG2M-Samplec.lateG1",
                              earlyg1_sg2m_control="Samplec.earlyG1-Samplec.SG2M",
                              levels=mod3)

#USE LIMMA-VOOM ANALYSIS 
#voom converts raw counts to log-cpm values 
v=voom(counts=data,design=mod2,plot=TRUE)
fit <- lmFit(v, mod2)
fit_with_exp<-lmFit(v,mod3)

fit2=contrasts.fit(fit,cont.matrix)
e2=eBayes(fit2)
fit3=contrasts.fit(fit_with_exp,cont.matrix_exp)
e3=eBayes(fit3)
plotSA(e2,"SVA-adjusted model, Mean-Variance Trend ")
plotSA(e3,"exp(SVA)-adjusted model, Mean-Variance Trend")
e2_summary=summary(decideTests(e2,p.value=0.05,lfc=1))
e3_summary=summary(decideTests(e3,p.value=0.05,lfc=1))

## ANALYSIS WITH DESEQ2 ## 
library("DESeq2")
ddsFullCountTable=DESeqDataSetFromMatrix(
  countData=round(data),
  colData=batches,
  design=~Sample+sva1
)
ddsFullCountTable_exp=DESeqDataSetFromMatrix(
  countData=round(data),
  colData=batches,
  design=~Sample+exp_sva
)

dds<-DESeq(ddsFullCountTable,parallel=TRUE)
dds_exp=DESeq(ddsFullCountTable_exp,parallel=TRUE)

 comparisons=colnames(cont.matrix)
 gene_names=unique_names
 for(i in c(1,2,3,5,6,9))
 {
   tab<-topTable(e2, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
   names(tab)[1]=comparisons[i]
   tab$Chrom_Start_End=rownames(tab)
   write.table(tab,file=paste("rna_differential_limma_",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
 }
 
 comparisons=colnames(cont.matrix_exp)
 for(i in c(1,2,3,5,6,9))
 {
   tab<-topTable(e3, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
   names(tab)[1]=comparisons[i]
   tab$Chrom_Start_End=rownames(tab)
   write.table(tab,file=paste("rna_differential_limma_exp",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
 }

#write out DESEQ2 results 
 cont.matrix_exp=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                               lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                               sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                               lateg1_earlyg1_dmso="Samplet.lateG1-Samplet.earlyG1",
                               sg2m_lateg1_dmso="Samplet.SG2M-Samplet.lateG1",
                               earlyg1_sg2m_dmso="Samplet.earlyG1-Samplet.SG2M",
                               lateg1_earlyg1_control="Samplec.lateG1-Samplec.earlyG1",
                               sg2m_lateg1_control="Samplec.SG2M-Samplec.lateG1",
                               earlyg1_sg2m_control="Samplec.earlyG1-Samplec.SG2M",
                               levels=mod3)
conditionsToCompare <-data.frame(
   matrix(
     c('t.earlyG1','c.earlyG1',
       't.lateG1','c.lateG1',
       't.SG2M','c.SG2M',
       't.lateG1','t.earlyG1',
       't.SG2M','t.lateG1',
       't.earlyG1','t.SG2M',
       'c.lateG1','c.earyG1',
       'c.SG2M','c.lateG1',
       'c.earlyG1','c.SG2M'
       ),
     ncol=2,
     byrow=TRUE),
   stringsAsFactors=FALSE)
 colnames(conditionsToCompare)<-c('first','second')
 
 numCols <- nrow(conditionsToCompare)
 for (i in c(1,2,3,4,5,6,8,9)){
   res <- results(dds, 
                  contrast = c("Sample", 
                               conditionsToCompare[i, 'first'], 
                               conditionsToCompare[i, 'second']), 
                  parallel = TRUE)
   res=na.omit(res)
   res=res[res$padj <=0.05 & abs(res$log2FoldChange)>=1,]
   res$Chrom_Start_End=rownames(res)
   write.table(res,file=paste("rna_differential_deseq2_",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
 }
 for (i in c(1,2,3,4,5,6,8,9)){
   res <- results(dds_exp, 
                  contrast = c("Sample", 
                               conditionsToCompare[i, 'first'], 
                               conditionsToCompare[i, 'second']), 
                  parallel = TRUE)
   res=na.omit(res)
   res=res[res$padj <=0.05 & abs(res$log2FoldChange)>=1,]
   res$Chrom_Start_End=rownames(res)
   write.table(res,file=paste("rna_differential_deseq2_exp",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
 }
 

 
 