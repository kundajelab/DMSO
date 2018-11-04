rm(list=ls())
library(limma)
library(sva)
library(ggplot2)

data=data.frame(read.table('../peak_aggregation_to_counts/atac.counts.txt',header=TRUE,sep='\t'))
chrom=data$Chrom
start_pos=data$Start
end_pos=data$End
rownames(data)=paste(chrom,start_pos,end_pos,sep="_")
data$Chrom=NULL
data$Start=NULL
data$End=NULL

batches=data.frame(read.table('../peak_aggregation_to_counts/batches.txt',header=TRUE,sep='\t'))

mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)
v=voom(counts=data,normalize.method = "quantile")
#sva 
sva.obj=sva(v$E,mod1,mod0)
colnames(sva.obj$sv)=c("sva1","sva2","sva3")
mod2=cbind(mod1,sva.obj$sv)
fit <- lmFit(v, mod2)
sv_contribs=coefficients(fit)[,c(5,6,7)] %*% t(fit$design[,c(5,6,7)])
data_corrected=v$E-sv_contribs
write.table(data_corrected,"new_ATAC.cpm.corrected",row.names=TRUE,col.names=TRUE,quote=FALSE)
data.pca=prcomp(t(data_corrected),center=FALSE,scale=FALSE)

barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),width=1,xlim=c(0,13),ylim=c(0,100),xlab="PC",ylab="% Variance Explained")
text(1:12,100*data.pca$sdev^2/sum(data.pca$sdev^2),labels=round(100*data.pca$sdev^2/sum(data.pca$sdev^2),2))
groups=factor(rownames(data.pca$x))
groups=gsub("_Rep1","",groups)
groups=gsub("_Rep2","",groups)
control_treated_groups=factor(c("Control","Control","DMSO","DMSO","Control","Control",
                                "DMSO","DMSO","Control","Control","DMSO","DMSO"))
time_groups=factor(c('earlyG1','earlyG1','earlyG1','earlyG1','lateG1','lateG1',
                     'lateG1','lateG1','SG2M','SG2M','SG2M','SG2M'))

rep_groups=factor(c(1,1,2,2,3,3,4,4,5,5,6,6))

source('~/helpers.R')
pca_df=as.data.frame(data.pca$x)
pca_df$label=groups 
pca_df$dmso=control_treated_groups
pca_df$time=time_groups
p1=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC2,color=pca_df$time,shape=pca_df$dmso))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC1")+
  ylab("PC2")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="none")


p2=ggplot(data=pca_df,aes(x=pca_df$PC2,y=pca_df$PC3,color=pca_df$time,shape=pca_df$dmso))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC2")+
  ylab("PC3")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="none")

p3=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC3,color=pca_df$time,shape=pca_df$dmso))+
  geom_point(show.legend=TRUE,size=5) +
  xlab("PC1")+
  ylab("PC3")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  theme(legend.position="none")
multiplot(p1,p2,p3,cols=1)


#We re-run the linear fit on the corrected data 
mod3=model.matrix(~0+Sample,data=batches)
fit2 <- lmFit(data_corrected, mod3)

#specify the contrasts 
cont.matrix=makeContrasts(earlyg1_dmso_control="SampleearlyG1_DMSO-SampleearlyG1_controls",
                          lateg1_dmso_control="SamplelateG1_DMSO-SamplelateG1_controls",
                          sg2m_dmso_control="SampleSG2M_DMSO-SampleSG2M_controls",
                          levels=mod3)
fit2=contrasts.fit(fit2,cont.matrix)
e=eBayes(fit2)
comparisons=colnames(cont.matrix)
for(i in seq(1,length(comparisons)))
{
  tab<-topTable(e, number=nrow(e),coef=i,p.value = 1)
  if(nrow(tab)>0){
    names(tab)[1]=comparisons[i]
    write.table(tab,file=paste("atac_differential_",comparisons[i],".tsv",sep=""),quote=FALSE,sep='\t',row.names = TRUE,col.names = TRUE)
    png(paste("volcano_peaks",comparisons[i],".png",sep=""))
    volcanoplot(e,coef=i,highlight =0,names=rownames(tab),main=comparisons[i])
    dev.off() 
  }
  else{
    write.table(tab,file=paste("atac_differential_",comparisons[i],".tsv",sep=""),quote=FALSE,sep='\t',row.names = FALSE,col.names = FALSE)
  }
}
