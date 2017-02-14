rm(list=ls())
library(limma)
library(devtools)
library(Biobase)
library(sva)
library(bladderbatch)
library(snpStats)
library(data.table)
data=data.frame(read.table('chipseq_merged.txt',header=TRUE,sep='\t'))
gene_ids=data$GeneIds
gene_names=data$GeneName
unique_names=paste(gene_ids,gene_names,sep="_")
data$GeneId=NULL
data$GeneName=NULL
rownames(data)=unique_names
#select just the columns for CellType, Day, Treatment 
batches_full=data.frame(read.table('batches.txt',header=TRUE,sep='\t'))
batches_full$Day=factor(batches_full$Day)
batches=subset(batches_full,select=c("CellType","Day","Treatment"))


#identify the surrogate variables! 
#f=batches_full$Replicate 
#f=factor(f)
#mod1=model.matrix(~0+f)

mod1=model.matrix(~CellType+Day+Treatment,data=batches)
#mod0=model.matrix(~1,data=batches)
v=voom(counts=data,design=mod1)
#sva.obj=sva(v$E,mod1,mod0,method="irw")
#sur_var=sva.obj$sv
#summary(lm(sva.obj$sv ~ batches$CellType+batches$Day+batches$Treatment))
#get rid of 1,3,4,5,6,7
#full.design.sv=cbind(mod1,sur_var)
#v=voom(counts=data,design=full.design.sv)
fit <- lmFit(v)
#sv_contribs=coefficients(fit)[,c(5,7,8,9,10,11)] %*% t(fit$design[,c(5,7,8,9,10,11)])
#data=data-sv_contribs
#write.csv(data,"rnaseq_fpkm_corrected.csv")

spearman_cor=cor(data,method="spearman")
pearson_cor=cor(data,method="pearson")

#work with corrected data to get differential expression!!
#v=voom(counts=data,design=mod1)
#fit <- lmFit(v)
e = eBayes(fit)
#Sat vs Mac
tab2<-topTable(e,number=nrow(data),lfc=1,p.value = 0.05,coef=2)
#Day 2 vs 0 
tab3<-topTable(e,number=nrow(data),lfc=1,p.value = 0.05,coef=2)
#Day 4 vs 0 
tab4<-topTable(e,number=nrow(data),lfc=1,p.value = 0.05,coef=2)
#Day 7 vs 0 
tab5<-topTable(e,number=nrow(data),lfc=1,p.value = 0.05,coef=2)
#WT vs KO 
tab6<-topTable(e,number=nrow(data),lfc=1,p.value = 0.05,coef=2)
cont.matrix=makeContrasts(Day4vsDay2="0*CellTypeSat+1*TreatmentWT+(Day4-Day2)-0*TreatmentWT+(Day4-Day2)",
                          Day7vsDay4="Day7-Day4",
                          levels=mod1)
