rm(list=ls())
library(ggplot2)
library(sva)
library(DESeq2)
library("BiocParallel")
parallelFlag=TRUE
register(MulticoreParam(20))
library(limma)

data=data.frame(read.table('../background_subtracted.txt',header=TRUE,sep='\t',stringsAsFactors=FALSE))
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
mod1=model.matrix(~Sample,data=batches)
sva.obj=svaseq(as.matrix(data),mod1,mod0)
sur_var=data.frame(sva.obj$sv)
names(sur_var)=c("sv1","sv2")
batches=cbind(batches,sur_var)


earlyG1_data=data[,1:4]

lateG1_data=data[,5:8]
sg2m_data=data[,9:12]

earlyG1_batches=batches[1:4,]
lateG1_batches=batches[5:8,]
sg2m_batches=batches[9:12,]
#refactor the batches
earlyG1_batches$Treatment=factor(earlyG1_batches$Treatment)
earlyG1_batches$CellCycle=NULL
earlyG1_batches$Sample=NULL

lateG1_batches$Treatment=factor(lateG1_batches$Treatment)
lateG1_batches$CellCycle=NULL
lateG1_batches$Sample=NULL

SG2M_batches$Treatment=factor(SG2M_batches$Treatment)
SG2M_batches$CellCycle=NULL
SG2M_batches$Sample=NULL

earlyG1_dds <- DESeqDataSetFromMatrix(countData = earlyG1_data,
                              colData = earlyG1_batches,
			      design = ~Treatment + sv1+sv2)
lateG1_dds <- DESeqDataSetFromMatrix(countData = lateG1_data,
                              colData = lateG1_batches,
			      design = ~Treatment + sv1+sv2)
sg2m_dds <- DESeqDataSetFromMatrix(countData = sg2m_data,
                              colData = sg2m_batches,
			      design = ~Treatment+sv1+sv2)

size_factors=read.table("../size_factors.txt",header=TRUE,sep='\t')
size_factors=as.vector(as.matrix(size_factors) )

sizeFactors(earlyG1_dds)=size_factors[1:4]
sizeFactors(lateG1_dds)=size_factors[5:8]
sizeFactors(sg2m_dds)=size_factors[9:12]

earlyG1_dds <- DESeq(earlyG1_dds,parallel = parallelFlag)
lateG1_dds <- DESeq(lateG1_dds,parallel = parallelFlag)
sg2m_dds <- DESeq(sg2m_dds,parallel = parallelFlag)

earlyG1_res=results(earlyG1_dds,parallel=TRUE)
lateG1_res=results(lateG1_dds,parallel=TRUE)
sg2m_res=results(sg2m_dds,parallel=TRUE)

earlyG1_res=results(earlyG1_dds,contrast=c("Treatment","DMSO","controls"),parallel=TRUE)
lateG1_res=results(lateG1_dds,contrast=c("Treatment","DMSO","controls"),parallel=TRUE)
sg2m_res=results(sg2m_dds,contrast=c("Treatment","DMSO","controls"),parallel=TRUE)

earlyG1_res$logPadj=-10*log10(earlyG1_res$padj)
earlyG1_res=as.data.frame(earlyG1_res)
earlyG1_res=na.omit(earlyG1_res)
earlyG1_numsig=sum(earlyG1_res$padj <=0.05)
earlyG1_sigsubset=earlyG1_res[earlyG1_res$padj<=0.05,]
write.table(earlyG1_sigsubset,file="diffpeaks.earlyG1.tsv",quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
print(paste(sample1[i],sample2[i],numsig))
outlabel=paste("earlyG1, DMSO v Control, Diff. peaks:",earlyG1_numsig)
earlyG1_res$color=earlyG1_res$padj<0.05
png("earlyG1.png")
 ggplot(data=earlyG1_res,
	aes(x=earlyG1_res$log2FoldChange,
	    y=earlyG1_res$logPadj,
	    color=earlyG1_res$color))+
	geom_point()+
	xlab("Log2(FC)")+
	ylab("-10*log10(P-adj)")+
	ggtitle(outlabel)+
	scale_color_manual(values=c("#000000","#ff0000"),name="P.adj<0.05")
dev.off()


lateG1_res$logPadj=-10*log10(lateG1_res$padj)
lateG1_res=as.data.frame(lateG1_res)
lateG1_res=na.omit(lateG1_res)
lateG1_numsig=sum(lateG1_res$padj <=0.05)
lateG1_sigsubset=lateG1_res[lateG1_res$padj<=0.05,]
write.table(lateG1_sigsubset,file="diffpeaks.lateG1.tsv",quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
print(paste(sample1[i],sample2[i],numsig))
outlabel=paste("lateG1, DMSO v Control, Diff. peaks:",lateG1_numsig)
lateG1_res$color=lateG1_res$padj<0.05
png("lateG1.png")
 ggplot(data=lateG1_res,
	aes(x=lateG1_res$log2FoldChange,
	    y=lateG1_res$logPadj,
	    color=lateG1_res$color))+
	geom_point()+
	xlab("Log2(FC)")+
	ylab("-10*log10(P-adj)")+
	ggtitle(outlabel)+
	scale_color_manual(values=c("#000000","#ff0000"),name="P.adj<0.05")
dev.off()


sg2m_res$logPadj=-10*log10(sg2m_res$padj)
sg2m_res=as.data.frame(sg2m_res)
sg2m_res=na.omit(sg2m_res)
sg2m_numsig=sum(sg2m_res$padj <=0.05)
sg2m_sigsubset=sg2m_res[sg2m_res$padj<=0.05,]
write.table(sg2m_sigsubset,file="diffpeaks.sg2m.tsv",quote=FALSE,sep='\t',row.names=TRUE,col.names=TRUE)
print(paste(sample1[i],sample2[i],numsig))
outlabel=paste("sg2m, DMSO v Control, Diff. peaks:",sg2m_numsig)
sg2m_res$color=sg2m_res$padj<0.05
png("sg2m.png")
 ggplot(data=sg2m_res,
	aes(x=sg2m_res$log2FoldChange,
	    y=sg2m_res$logPadj,
	    color=sg2m_res$color))+
	geom_point()+
	xlab("Log2(FC)")+
	ylab("-10*log10(P-adj)")+
	ggtitle(outlabel)+
	scale_color_manual(values=c("#000000","#ff0000"),name="P.adj<0.05")
dev.off()
