rm(list=ls())
library(ggplot2)
library(sva)
library(DESeq2)
library("BiocParallel")
parallelFlag=TRUE
register(MulticoreParam(20))
library(limma)

data=data.frame(read.table('../background_subtracted.txt',header=TRUE,sep='\t'))
rownames(data)=paste(data$Chrom,data$Start,data$End,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL
data[data<0]=0
data=data[rowSums(data)>0,]

#load the normalization factors
normfactors=data.frame(read.table("../norm_factors.txt",header=TRUE,sep='\t'))
normfactors=normfactors[1:nrow(data),]
rownames(normfactors)=rownames(data)

batches=data.frame(read.table("../atacseq_batches_truerep.txt",header=TRUE,sep='\t'))
rownames(batches)=batches$Replicate
batches$CellCycle=factor(batches$CellCycle)
batches$Treatment=factor(batches$Treatment)
batches$Sample=factor(batches$Sample)
batches$Replicate=NULL


#svaseq
mod0=model.matrix(~1,data=batches)
mod1=model.matrix(~ Treatment + CellCycle,data=batches)
sva.obj=svaseq(as.matrix(data),mod1,mod0)
sur_var=data.frame(sva.obj$sv)
names(sur_var)=c("sv1","sv2","sv3")
batches=cbind(batches,sur_var)

dds <- DESeqDataSetFromMatrix(countData = data,
                              colData = batches,
			      design = ~Sample + sv1+sv2+sv3)

size_factors=read.table("../size_factors.txt",header=TRUE,sep='\t')
size_factors=as.vector(as.matrix(size_factors) )
sizeFactors(dds)=size_factors
dds <- DESeq(dds,parallel = parallelFlag)

#extract the normalized counts for purposes of PCA & heatmap
normcounts=counts(dds,normalized=TRUE)
covariates=batches[c("sv1","sv2","sv3")]
normcounts=removeBatchEffect(normcounts,design=mod1,covariates=covariates)
write.table(normcounts,"normcounts_from_deseq.txt",quote=FALSE,sep='\t',col.names=TRUE,row.names=TRUE)

#get the results for various contrasts
sample1=c("earlyG1_DMSO","lateG1_DMSO","SG2M_DMSO")
sample2=c("earlyG1_controls","lateG1_controls","SG2M_controls")
numcomparisons=length(sample1)
for(i in seq(1,numcomparisons))
{
 res=results(dds,contrast=c("Sample",sample1[i],sample2[i]),parallel=TRUE)
 res$logPadj=-10*log10(res$padj)
 res=as.data.frame(res)
 res=na.omit(res)
 numsig=sum(res$padj <= 0.05)
 sigsubset=res[res$padj<=0.05,]
 outtable=paste("diffpeaks",sample1[i],sample2[i],"tsv",sep='.')
 write.table(sigsubset,file=outtable,quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
 print(paste(sample1[i],sample2[i],numsig))
 outpng=paste("volcano",sample1[i],sample2[i],"png",sep='.')
 outlabel=paste(sample1[i],'vs.',sample2[i],"Diff. peaks:",numsig)
 res$color=res$padj<=0.05
 #svg(outpng,width=5,height=5,pointsize=12)
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


