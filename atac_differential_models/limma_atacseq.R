rm(list=ls())
library(limma)
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)

data=data.frame(read.table('../atacseq_merged.txt',header=TRUE,sep='\t'))
chrom=data$Chrom
start_pos=data$Start
end_pos=data$End
unique_names=paste(chrom,start_pos,end_pos,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL
rownames(data)=unique_names

batches=data.frame(read.table('atacseq_batches.txt',header=TRUE,sep='\t'))
#pc1 is weird -- no correspondence to DMSO vs Control or Timepoint , need to perform SVA

mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
browser() 
mod0=model.matrix(~1,data=batches)
v=voom(counts=data,design=mod1)
#sva 
sva.obj=sva(v$E,mod1,mod0)
colnames(sva.obj$sv)=c("sva1","sva2","sva3","sva4","sva5")
mod2=cbind(mod1,sva.obj$sv)
v=voom(counts=data,design=mod2)
fit <- lmFit(v, mod2)
sv_contribs=coefficients(fit)[,c(5,6,7,8,9)] %*% t(fit$design[,c(5,6,7,8,9)])
data_corrected=v$E-sv_contribs

data.pca=prcomp(t(data_corrected),center=FALSE,scale=FALSE)
barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),las=2,xlab="",ylab="% Variance Explained")
plot(data.pca$x[,c(1,2)],col=batches$Rep,pch=16)
text(data.pca$x[,c(1,2)],labels=batches$Rep,pos=3,cex=1)
title("PC1 vs PC2")
plot(data.pca$x[,c(1,3)],col=batches$Rep,pch=16)
text(data.pca$x[,c(1,3)],labels=batches$Rep,pos=3,cex=1)
title("PC1 vs PC3")
plot(data.pca$x[,c(2,3)],col=batches$Rep,pch=16)
text(data.pca$x[,c(2,3)],labels=batches$Rep,pos=3,cex=1)
title("PC2 vs PC3")
#write.csv(data_corrected,"atac_corrected.csv")

#We re-run the linear fit on the corrected data 
mod3=model.matrix(~0+Sample,data=batches)
fit2 <- lmFit(data_corrected, mod3)

#fit <- lmFit(v)
#plotMDS(v)

#specify the contrasts 
cont.matrix=makeContrasts(earlyg1_dmso_control="Sampleatac_earlyG1_ld_treated-Sampleatac_earlyG1_ld_control",
                          lateg1_dmso_control="Sampleatac_lateG1_ld_treated-Sampleatac_lateG1_ld_control",
                          sg2m_dmso_control="Sampleatac_SG2M_ld_treated-Sampleatac_SG2M_ld_control",
                          lateg1_earlyg1_dmso="Sampleatac_lateG1_ld_treated-Sampleatac_earlyG1_ld_treated",
                          sg2m_lateg1_dmso="Sampleatac_SG2M_ld_treated-Sampleatac_lateG1_ld_treated",
                          earlyg1_sg2m_dmso="Sampleatac_earlyG1_ld_treated-Sampleatac_SG2M_ld_treated",
                          lateg1_earlyg1_control="Sampleatac_lateG1_ld_control-Sampleatac_earlyG1_ld_control",
                          sg2m_lateg1_control="Sampleatac_SG2M_ld_control-Sampleatac_lateG1_ld_control",
                          earlyg1_sg2m_control="Sampleatac_earlyG1_ld_control-Sampleatac_SG2M_ld_control",
                          levels=mod3)
fit2=contrasts.fit(fit2,cont.matrix)
e=eBayes(fit2)
comparisons=colnames(cont.matrix)
gene_names=unique_names
for(i in seq(1,9))
{
  tab<-topTable(e, number=nrow(data),coef=i,lfc=1,p.value = 0.05)
  names(tab)[1]=comparisons[i]
  tab$Chrom_Start_End=rownames(tab)
  write.table(tab,file=paste("atac_differential_",comparisons[i],".tsv",sep=""),quote=TRUE,sep='\t',row.names = FALSE)
}
