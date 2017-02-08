rm(list=ls())
#library(ggbiplot)
library(data.table)
#data=data.frame(read.table('presence_tasks_stringent.txt',header=T,sep='\t'))
#data=data.frame(read.table('macs.fc.averaged.tab',header=T,sep='\t'))
#data$Chrom=NULL
#data$Start=NULL 
#data$End=NULL 
data=data.frame(read.table('atac_corrected.csv',header=T,sep='\t'))
data$ID=NULL
data.pca=prcomp(t(data),center=FALSE,scale=FALSE)
barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),las=2,xlab="",ylab="% Variance Explained")
text(c(1:5),c(88.5,3.99,1.10,.726,0.477),c("88.5","3.99","1.10","0.726","0.477"))
groups=factor(rownames(data.pca$x))

#PC1 vs PC2
dense_groups=factor(c("HD","HD","HD","HD","LD","LD","LD","LD",
              "HD","HD","HD","HD","LD","LD","LD","LD",
              "HD","HD","HD","HD","LD","LD","LD","LD"))
batches=factor(c(
                 2,2,2,2,2,2,2,2,
                 2,2,2,2,2,2,2,2,
                 2,2,2,2,2,2,2,2))
control_treated_groups=factor(c(
				1,1,2,2,1,1,2,2,
        1,1,2,2,1,1,2,2,
        1,1,2,2,1,1,2,2))

#plot(data.pca$x[,c(1,2)],col=dense_groups,pch=16)
#text(data.pca$x[,c(1,2)],labels=groups,pos=3,cex=0.5)
#title("PC1 vs PC2 separates HD (high density) and LD (low density) samples")

plot(data.pca$x[,c(1,2)],col=control_treated_groups,pch=16)
text(data.pca$x[,c(1,2)],labels=groups,pos=3,cex=0.5)
title("PC1 vs PC2")
plot(data.pca$x[,c(1,3)],col=control_treated_groups,pch=16)
text(data.pca$x[,c(1,3)],labels=groups,pos=3,cex=0.5)
title("PC1 vs PC3")
plot(data.pca$x[,c(2,3)],col=batches,pch=16)
text(data.pca$x[,c(2,3)],labels=groups,pos=3,cex=0.5)
title("PC2 vs PC3")
browser() 

#PC2 vs PC3
dense_treatment_groups=factor(c("Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD",
                                "Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD",
                                "Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD"))
plot(data.pca$x[,c(2,3)],col=dense_treatment_groups,pch=16)
text(data.pca$x[,c(2,3)],labels=groups,pos=3,cex=0.5)
title('PC2 vs PC3 separates 4 clusters: Control/HD, Control/LD, Treated/HD, Treated/LD')

#PC1 vs PC3
#time_groups=factor(c("earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1",
#                   "lateG1","lateG1","lateG1","lateG1","lateG1","lateG1","lateG1","lateG1",
#                   "SG2M","SG2M","SG2M","SG2M","SG2M","SG2M","SG2M","SG2M"))
time_groups=factor(c(1,1,1,1,1,1,1,1,
                     2,2,2,2,2,2,2,2,
                     3,3,3,3,3,3,3,3))
plot(data.pca$x[,c(1,3)],col=control_treated_groups,pch = 16)
text(data.pca$x[,c(1,3)],labels=groups,pos=3,cex=0.5)
title("PC1 vs PC3")

#PC2 vs PC4
plot(data.pca$x[,c(2,4)],col=time_groups,pch = 16)
text(data.pca$x[,c(2,4)],labels=groups,pos=3,cex=0.5)
title("PC2 vs PC4") 
#title("Component 4 separates samples by cell cycle timepoint, component 2 separates samples by cell density")


plot(data.pca$x[,c(2,5)],col=time_groups,pch = 16)
text(data.pca$x[,c(2,5)],labels=groups,pos=3,cex=0.5)
title("PC2 vs PC5") 
#title("PC4 separates samples by cell cycle timepoint; PC3 separates samples by Treated vs Control")
