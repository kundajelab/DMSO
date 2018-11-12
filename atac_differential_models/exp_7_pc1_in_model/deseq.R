rm(list=ls())
library(ggplot2)
library(sva)
library(DESeq2)
library("BiocParallel")
parallelFlag=TRUE
register(MulticoreParam(20))
library(limma)

#load ATAC-seq raw read counts 
data=read.table('atac.counts.txt',header=TRUE,sep='\t')
rownames(data)=paste(data$Chrom,data$Start,data$End,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL




#load the metadata 
batches=read.table("../atacseq_batches_truerep.txt",header=TRUE,sep='\t',row.names=1)
batches$CellCycle=factor(batches$CellCycle)
batches$Treatment=factor(batches$Treatment)
batches$Sample=factor(batches$Sample)


#Perform PCA analysis on the data
data.pca=prcomp(t(data),center=FALSE,scale=TRUE)
pca_df=as.data.frame(data.pca$x)
batches=cbind(pca_df,batches)


#Create DESeq object 
dds <- DESeqDataSetFromMatrix(countData = data,
                              colData = batches,
			      design = ~CellCycle + CellCycle:Treatment +PC1)

#perform size factor normalization for HK promoters
hk_promoters=read.table("HK.promoters.txt",header=TRUE,sep='\t')
hk_promoters=paste(hk_promoters$Chrom,hk_promoters$Start,hk_promoters$End,sep="_")
hk_promoter_indices=match(hk_promoters,rownames(data))

dds <- estimateSizeFactors(dds, controlGenes=hk_promoter_indices)


#Run the differential analysis 
dds <- DESeq(dds,parallel = parallelFlag)

#extract the normalized counts for purposes of PCA & heatmap
normcounts=counts(dds,normalized=TRUE)
mod1=model.matrix(~ Treatment + CellCycle,data=batches)
normcounts=removeBatchEffect(normcounts,design=mod1,covariates=batches[c("PC1")])
write.table(normcounts,"normcounts_from_deseq2.txt",quote=FALSE,sep='\t',col.names=TRUE,row.names=TRUE)

#get the results for various contrasts
resultsNames(dds)
namesToOutput=c("CellCycle_lateG1_vs_earlyG1",
"CellCycle_SG2M_vs_earlyG1",
"CellCycleearlyG1.TreatmentDMSO",
"CellCyclelateG1.TreatmentDMSO",
"CellCycleSG2M.TreatmentDMSO")
numcomparisons=length(namesToOutput)
for(i in seq(1,numcomparisons))
{
 res=results(dds,name=namesToOutput[i],parallel=TRUE) 
 res$logPadj=-10*log10(res$padj)
 res=as.data.frame(res)
 res=na.omit(res)
 numsig=sum(res$padj <= 0.05)
 sigsubset=res[res$padj<=0.05,]

 #output differential analysis results for the contrast 
 outtable=paste(namesToOutput[i],"tsv",sep='.')
 write.table(sigsubset,file=outtable,quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
 print(paste(namesToOutput[i],numsig))

 #generate a volcano plot of the differential analysis for the contrast 
 outpng=paste("volcano",namesToOutput[i],"png",sep='.')
 outlabel=paste(namesToOutput[i],"Diff. peaks:",numsig)
 res$color=res$padj<=0.05
 
 png(outpng)#,width=5,height=5,pointsize=12)
 ggplot(data=res,
	aes(x=res$log2FoldChange,
	    y=res$logPadj,
	    color=res$color))+
	geom_point()+
	xlab("Log2(FC)")+
	ylab("-10*log10(P-adj)")+
	ggtitle(outlabel)+
	scale_color_manual(values=c("#000000","#ff0000"),name="P.adj<0.05")
 dev.off()
}

#get SG2M vs lateG1 effect 
res=results(dds, contrast=list("CellCycle_SG2M_vs_earlyG1","CellCycle_lateG1_vs_earlyG1"))
 res$logPadj=-10*log10(res$padj)
 res=as.data.frame(res)
 res=na.omit(res)
 numsig=sum(res$padj <= 0.05)
 sigsubset=res[res$padj<=0.05,]

 #output differential analysis results for the contrast 
 outtable=paste("CellCycle_SG2M_vs_lateG1.tsv",sep='.')
 write.table(sigsubset,file=outtable,quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)

 #generate a volcano plot of the differential analysis for the contrast 
 outpng=paste("volcano","CellCycle_SG2M_vs_lateG1","png",sep='.')
 outlabel=paste("CellCycle_SG2M_vs_lateG1","Diff. peaks:",numsig)
 res$color=res$padj<=0.05
 
 png(outpng)#,width=5,height=5,pointsize=12)
 ggplot(data=res,
	aes(x=res$log2FoldChange,
	    y=res$logPadj,
	    color=res$color))+
	geom_point()+
	xlab("Log2(FC)")+
	ylab("-10*log10(P-adj)")+
	ggtitle(outlabel)+
	scale_color_manual(values=c("#000000","#ff0000"),name="P.adj<0.05")
 dev.off()
