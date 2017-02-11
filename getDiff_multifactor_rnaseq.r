library("DESeq2")
library("RColorBrewer")
library("gplots")
library("dplyr")
library("BiocParallel")
library("ggplot2")
library(data.table)

# Metadata

padjCutoff <- 0.01 # If this is not 0.1, we have to tweak DESeq's filtering.
register(MulticoreParam(20))
parallelFlag <- TRUE

countData=data.frame(read.table("counts.rna",header=T,sep='\t'))
countData=ceiling(countData)
countData[countData<0]=0
colData=data.frame(read.table("counts.metadata.rna",header=T,sep='\t'))

ddsFullCountTable<-DESeqDataSetFromMatrix(
	countData=countData,
	colData=colData,
	design= ~Sample)
dds<-DESeq(ddsFullCountTable,parallel=parallelFlag)


# Generate differential openness matrix
# Each column is a pair of (treated, controls) conditions 
# as specified in conditionsToCompare
conditionsToCompare <-data.frame(
matrix(
	c('t.earlyG1','t.lateG1',
       	't.earlyG1','t.SG2M',
       	't.SG2M','c.SG2M',
       	't.lateG1','c.lateG1',
       	't.earlyG1','c.earlyG1'),
       	ncol=2,
       	byrow=TRUE),
       	stringsAsFactors=FALSE)
colnames(conditionsToCompare)<-c('first','second')
conditionsToCompare <- mutate(conditionsToCompare, 
                              both = paste(first,second, sep = "-"))

numCols <- nrow(conditionsToCompare)
numRows <- nrow(countData)
diffMat <- matrix(, ncol = numCols, nrow = numRows)
confidenceMat<-matrix(,ncol=numCols, nrow=numRows)
foldChangeMat<-matrix(,ncol=numCols,nrow=numRows) 

colNameEntries=c()
for (i in 1:numCols){
  res <- results(dds, 
                 contrast = c("Sample", 
                              conditionsToCompare[i, 'first'], 
                              conditionsToCompare[i, 'second']), 
                 parallel = parallelFlag)
    colNameEntries=append(colNameEntries,paste(conditionsToCompare[i,1],"_vs_",conditionsToCompare[i,2],sep=""))
  low_deltas=which(abs(res$log2FoldChange)<0.15)
  res$log2FoldChange[low_deltas]=0
  diffMat[, i] <- (res$padj <= padjCutoff) * sign(res$log2FoldChange)
  confidenceMat[,i]<-res$padj
  foldChangeMat[,i]<-res$log2FoldChange
}


# Replace NAs and filter out all rows of diffMat that are all zero
# Remember to take abs so that +1s and -1s don't cancel each other out

diffMat[is.na(diffMat)] <- 0
confidenceMat[is.na(confidenceMat)]<-1
foldChangeMat[is.na(foldChangeMat)]<-0 
colnames(diffMat) <- colNameEntries
colnames(confidenceMat)<-colNameEntries
colnames(foldChangeMat)<-colNameEntries

# Write diffMat to disk
write.table(diffMat,file = "rna.diffMat.tsv",sep='\t')
write.table(confidenceMat,file = "rna.confidenceMat.tsv",sep='\t')
write.table(foldChangeMat,file = "rna.fcMat.tsv",sep='\t')