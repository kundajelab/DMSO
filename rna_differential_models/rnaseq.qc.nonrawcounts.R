rm(list=ls())
library(limma)
library(sva)
library(data.table)

## SVA ANALYSIS FOR TPM DATA
data=data.frame(read.table('../rsem.tpm.csv',header=TRUE,sep='\t'))

#keep track of the gene names in a variable 
unique_names=data$GENE
rownames(data)=unique_names
data$GENE=NULL


#remove any genes that have all 0  counts 
all_zero_indices=which(rowSums(data)==0)
data=data[-all_zero_indices,]
data=as.matrix(data)

#take the asinh 
data=asinh(data)

#get the sva's 
batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
#pc1 is weird -- no correspondence to DMSO vs Control or Timepoint , need to perform SVA

mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

#svaseq -- sva must be used with normalized data 
sva.obj=sva(data,mod1,mod0)
sva.obj=data.frame(sva.obj$sv)
sva.obj$exp_X1=exp(sva.obj$X1)
sva.obj$exp_X2=exp(sva.obj$X2)
sva.obj$exp_X3=exp(sva.obj$X3)

batches$sva1=sva.obj$X1
batches$sva2=sva.obj$X2
batches$sva3=sva.obj$X3

batches$exp_sva1=sva.obj$exp_X1
batches$exp_sva2=sva.obj$exp_X2 
batches$exp_sva3=sva.obj$exp_X3

#add in surrogate variables into the model matrix 
mod2=model.matrix(~0+Sample+sva1+sva2+sva3,data=batches)
mod3=model.matrix(~0+Sample+exp_sva1+exp_sva2+exp_sva3,data=batches)

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

#USE LIMMA ANALYSIS 
fit <- lmFit(as.matrix(data), mod2)
fit_with_exp<-lmFit(as.matrix(data),mod3)

fit2=contrasts.fit(fit,cont.matrix)
e2=eBayes(fit2)
fit3=contrasts.fit(fit_with_exp,cont.matrix_exp)
e3=eBayes(fit3)
plotSA(e2,"SVA-adjusted model, Mean-Variance Trend ")
plotSA(e3,"exp(SVA)-adjusted model, Mean-Variance Trend")
e2_summary=summary(decideTests(e2,p.value=0.05,lfc=1))
e3_summary=summary(decideTests(e3,p.value=0.05,lfc=1))


comparisons=colnames(cont.matrix)
gene_names=unique_names
for(i in c(1,2,3,4,5,6,7,8,9))
{
  tab<-topTable(e2, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
  if(nrow(tab)>0){
  names(tab)[1]=comparisons[i]
  tab$Chrom_Start_End=rownames(tab)
  }
  write.table(tab,file=paste("rna_differential_limma_tpm",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
}

comparisons=colnames(cont.matrix_exp)
for(i in c(1,2,3,4,5,6,7,8,9))
{
  tab<-topTable(e3, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
  if(nrow(tab)>0){
  names(tab)[1]=comparisons[i]
  tab$Chrom_Start_End=rownames(tab)
  }
  write.table(tab,file=paste("rna_differential_limma_exp_tpm",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
}


