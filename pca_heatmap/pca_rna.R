rm(list=ls())
#library(ggbiplot)
library(data.table)

#OLD RSEM 
#data=data.frame(read.table('rsem.results.filtered',header=TRUE,sep='\t'))

#NEW RSEM 
data=data.frame(read.table('~/nandi/new_kallisto/new_Kallisto.tpm.corrected',header=TRUE,sep='\t',row.names = 1))
#data$GENE=NULL

#NEW KALLISTO 
#data=data.frame(read.table('~/nandi/new_kallisto/new_Kallisto.tpm.corrected',header=TRUE,sep='\t',row.names = 1))

data.pca=prcomp(t(data),center=TRUE,scale=TRUE)
barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),width=1,xlim=c(0,13),ylim=c(0,100),xlab="PC",ylab="% Variance Explained")
text(1:12,100*data.pca$sdev^2/sum(data.pca$sdev^2),labels=round(100*data.pca$sdev^2/sum(data.pca$sdev^2),2))
groups=factor(rownames(data.pca$x))
groups=gsub(".r2","",groups)
groups=gsub(".r1","",groups)
control_treated_groups=factor(c("Control","Control","Control","Control","Control","Control",
                                "DMSO","DMSO","DMSO","DMSO","DMSO","DMSO"))
time_groups=factor(c('earlyG1','earlyG1','lateG1','lateG1','SG2M','SG2M',
                     'earlyG1','earlyG1','lateG1','lateG1','SG2M','SG2M'))

rep_groups=factor(c(1,1,2,2,3,3,4,4,5,5,6,6))

# plot(data.pca$x[,c(1,2)],col=control_treated_groups,pch=16)
# text(data.pca$x[,c(1,2)],labels=groups,pos=3,cex=1)
# title("PC1 vs PC2")
# plot(data.pca$x[,c(1,3)],col=time_groups,pch=16)
# text(data.pca$x[,c(1,3)],labels=groups,pos=3,cex=1)
# title("PC1 vs PC3")
# plot(data.pca$x[,c(2,3)],col=time_groups,pch=16)
# text(data.pca$x[,c(2,3)],labels=groups,pos=3,cex=1)
# title("PC2 vs PC3")
# plot(data.pca$x[,c(3,4)],col=time_groups,pch = 16)
# text(data.pca$x[,c(3,4)],labels=groups,pos=3,cex=1)
# title("PC3 vs PC4")
# plot(data.pca$x[,c(2,5)],col=groups,pch = 16)
# text(data.pca$x[,c(2,5)],labels=groups,pos=3,cex=1)
# title("PC2 vs PC5") 

####################################################################
#ggplot pca fig
source('helpers.R')
library(ggplot2)
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

