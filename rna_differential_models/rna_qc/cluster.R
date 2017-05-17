rm(list=ls())
library(ggplot2)
library(DESeq2)
library(reshape2)
library(ggplot2)

#read in counts 
counts=read.table("rsem.expected_count.tsv",header=TRUE,sep='\t',row.names=1)
counts=round(counts)
all_zero_indices=which(rowSums(counts)==0)
counts=counts[-all_zero_indices,]
rn=rownames(counts)
counts=rlogTransformation(as.matrix(counts))
rownames(counts)=rn
counts_df=as.data.frame(counts)
mean_counts_df=data.frame(c.earlyG1=rowMeans(cbind(counts_df$c.earlyG1.r1,counts_df$c.earlyG1.r2)),
                          c.lateG1=rowMeans(cbind(counts_df$c.lateG1.r1,counts_df$c.lateG1.r2)),
                          c.SG2M=rowMeans(cbind(counts_df$c.SG2M.r1,counts_df$c.SG2M.r2)),
                          t.earlyG1=rowMeans(cbind(counts_df$t.earlyG1.r1,counts_df$t.earlyG1.r2)),
                          t.lateG1=rowMeans(cbind(counts_df$t.lateG1.r1,counts_df$t.lateG1.r2)),
                          t.SG2M=rowMeans(cbind(counts_df$t.SG2M.r1,counts_df$t.SG2M.r2)))
rownames(mean_counts_df)=rownames(counts_df)
############################################################################################################


#read in tpm
tpm=read.table("rsem.tpm.csv",header=TRUE,sep='\t',row.names=1)
all_zero_indices=which(rowSums(tpm)==0)
tpm=tpm[-all_zero_indices,]
tpm=asinh(tpm)

#sva on tpm 
batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)
library(sva)
library(limma) 
sva_tpm=sva(as.matrix(tpm),mod1,mod0)
sva_tpm=data.frame(sva_tpm$sv)
batches$sva1=sva_tpm$X1
batches$sva2=sva_tpm$X2
batches$sva3=sva_tpm$X3
#add in surrogate variables into the model matrix
mod3=model.matrix(~0+Sample+sva1+sva2+sva3,data=batches)
fit2 <- lmFit(as.matrix(tpm), mod3)
#subtract the SV contribs
sv_contribs=coefficients(fit2)[,c(7,8,9)] %*% t(fit2$design[,c(7,8,9)])
tpm_corrected=na.omit(tpm-sv_contribs) 
mean_tpm_corrected=data.frame(c.earlyG1=rowMeans(cbind(tpm_corrected$c.earlyG1.r1,tpm_corrected$c.earlyG1.r2)),
                          c.lateG1=rowMeans(cbind(tpm_corrected$c.lateG1.r1,tpm_corrected$c.lateG1.r2)),
                          c.SG2M=rowMeans(cbind(tpm_corrected$c.SG2M.r1,tpm_corrected$c.SG2M.r2)),
                          t.earlyG1=rowMeans(cbind(tpm_corrected$t.earlyG1.r1,tpm_corrected$t.earlyG1.r2)),
                          t.lateG1=rowMeans(cbind(tpm_corrected$t.lateG1.r1,tpm_corrected$t.lateG1.r2)),
                          t.SG2M=rowMeans(cbind(tpm_corrected$t.SG2M.r1,tpm_corrected$t.SG2M.r2)))
rownames(mean_tpm_corrected)=rownames(tpm_corrected)
############################################################################################################

c25 <- c("dodgerblue2","#E31A1C", # red
         "green4",
         "#6A3D9A", # purple
         "#FF7F00", # orange
         "black","gold1",
         "skyblue2","#FB9A99", # lt pink
         "palegreen2",
         "#CAB2D6", # lt purple
         "#FDBF6F", # lt orange
         "gray70", "khaki2",
         "maroon","orchid1","deeppink1","blue1","steelblue4",
         "darkturquoise","green1","yellow4","yellow3",
         "darkorange4","brown")

############################################################################################################
#k-means on rlogTransform(counts)
for(k in seq(25))
{
#fit <- kmeans(mean_counts_df, k)
fit  = kmeans(d,k)
means_melted=melt(fit$centers)
means_melted$Var1=factor(means_melted$Var1)
p=ggplot(means_melted,aes(x=means_melted$Var2,
                        y=means_melted$value,
                        group=means_melted$Var1,
                        colour=means_melted$Var1))+
  geom_line(size=1)+
  xlab("Timepoint")+
  ylab("centroids(rlogTransform(counts))")+
  scale_color_discrete(labels=as.character(fit$size),
                       name="Cluster Size",
                       breaks=seq(1,k))+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90))
p
}
####################################################################################################################
#tpm-corrected
for(k in seq(25))
{
  fit <- kmeans(mean_tpm_corrected, k)
  means_melted=melt(fit$centers)
  means_melted$Var1=factor(means_melted$Var1)
  p=ggplot(means_melted,aes(x=means_melted$Var2,
                          y=means_melted$value,
                          group=means_melted$Var1,
                          colour=means_melted$Var1))+
    geom_line()+
    xlab("Timepoint")+
    ylab("centroids(asinh(tpm)-sva)")+
    scale_color_discrete(labels=as.character(fit$size),
                         name="Cluster Size",
                         breaks=seq(1,k))+
    theme_bw(20)+
    theme(axis.text.x = element_text(angle = 90))
}
####################################################################################################################
for(k in seq(40))
{
  fit <- kmeans(mean_tpm_corrected, k)
  means_melted=melt(fit$centers)
  means_melted$Var1=factor(means_melted$Var1)
  p=ggplot(means_melted,aes(x=means_melted$Var2,
                            y=means_melted$value,
                            group=means_melted$Var1,
                            colour=means_melted$Var1))+
    geom_line()+
    xlab("Timepoint")+
    ylab("centroids(asinh(tpm)-sva)")+
    theme_bw(20)+
    theme(axis.text.x = element_text(angle = 90))
}
#i=1
for(i in seq(1,30)){
a=as.data.frame(fit$centers[i,])
a$time=rownames(a)
names(a)=c("value","time")
p=ggplot(a,aes(x=factor(a$time),
               y=a$value,
               group=1))+
  geom_line()+
  xlab("Timepoint")+
  ylab("centroids(asinh(tpm)-sva)")+
  theme_bw(20)+
  theme(axis.text.x = element_text(angle = 90))+
  ggtitle(fit$size[i])+
  ylim(-1,8)
ggsave(paste("scratch/",i,".png",sep=''),plot=p)
}
write.table(names(which(fit$cluster==i)),paste("cluster",i,".tsv",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE)
rna=mean_tpm_corrected[names(which(fit$cluster==i)),]
heatmap.2(as.matrix(rna),
          Colv=FALSE,
          col=redgreen(30),
          scale="row",
          trace="none",
          dendrogram = "none",
          margins=c(10,10),
          cexRow = 1,
          cexCol=1,
          main="RNA's up in Control lateG1")
