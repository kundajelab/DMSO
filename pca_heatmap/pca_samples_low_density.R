rm(list=ls())
source('helpers.R')
library(ggplot2)

data=data.frame(read.table('macs.fc.averaged.tab',header=T,sep='\t'))
data=data[,c(5,6,7,8,13,14,15,16,21,22,23,24)]
data.pca=prcomp(t(data),center=FALSE,scale=FALSE)
barplot(100*data.pca$sdev^2/sum(data.pca$sdev^2),las=2,xlab="",ylab="% Variance Explained")

groups=factor(rownames(data.pca$x))
groups=gsub("_r2","",groups)
groups=gsub("_r1","",groups)
control_treated_groups=factor(c("Control","Control","DMSO","DMSO",
                                "Control","Control","DMSO","DMSO",
                                "Control","Control","DMSO","DMSO"))
time_groups=factor(c("earlyG1","earlyG1","earlyG1","earlyG1",
                     "lateG1","lateG1","lateG1","lateG1",
                     "SG2M","SG2M","SG2M","SG2M"))
rep_groups=factor(c(1,1,2,2,3,3,4,4,5,5,6,6))

pca_df=as.data.frame(data.pca$x)
pca_df$label=c("control.earlyG1","control.earlyG1","DMSO.earlyG1","DMSO.earlyG1",
               "control.lateG1","control.lateG1","DMSO.lateG1","DMSO.lateG1",
               "control.SG2M","control.SG2M","DMSO.SG2M","DMSO.SG2M")
pca_df$dmso=control_treated_groups
pca_df$time=time_groups
p1=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC2,color=pca_df$time,label=pca_df$label))+
  geom_text(vjust="inward",hjust="inward", nudge_x = 0.05,nudge_y=0.05,show.legend=FALSE)+geom_point(show.legend=FALSE) +
  xlab("PC1")+
  ylab("PC2")+
  scale_color_discrete(name = "Cell Cycle Phase")

p2=ggplot(data=pca_df,aes(x=pca_df$PC2,y=pca_df$PC3,color=pca_df$time,label=pca_df$label))+
  geom_text(vjust="inward",hjust="inward", nudge_x = 0.05,nudge_y=0.05,show.legend=FALSE)+geom_point(show.legend=FALSE) +
  xlab("PC2")+
  ylab("PC3")+
  scale_color_discrete(name = "Cell Cycle Phase")

p3=ggplot(data=pca_df,aes(x=pca_df$PC1,y=pca_df$PC3,color=pca_df$time,label=pca_df$label))+
  geom_text(vjust="inward",hjust="inward", nudge_x = 0.05,nudge_y=0.05,show.legend=FALSE)+geom_point(show.legend=FALSE) +
  xlab("PC1")+
  ylab("PC3")+
  scale_color_discrete(name = "Cell Cycle Phase")
multiplot(p1,p2,p3,cols=3)

#FINAL FIGURE PLOT (PC2 vs PC3 shows greates seperation between DMSO & Controls and between early G1, late G1, SG2M)
ggplot(data=pca_df,aes(x=pca_df$PC2,y=pca_df$PC3,color=pca_df$time,shape=pca_df$dmso))+
  geom_point(show.legend=TRUE,size=10) +
  xlab("PC2")+
  ylab("PC3")+
  scale_shape_discrete(name="DMSO vs Control")+
  scale_color_manual(name = "Cell Cycle Phase",values = c("#7570b3", "#d95f02", "#1b9e77"))+
  ggtitle("ATAC-SEQ")
#PC1 vs PC2
#dense_groups=factor(c("HD","HD","HD","HD","LD","LD","LD","LD",
#              "HD","HD","HD","HD","LD","LD","LD","LD",
#              "HD","HD","HD","HD","LD","LD","LD","LD"))
# dense_treatment_groups=factor(c("Co_LD","Co_LD","Tr_LD","Tr_LD",
#                                 "Co_LD","Co_LD","Tr_LD","Tr_LD",
#                                 "Co_LD","Co_LD","Tr_LD","Tr_LD"))

# plot(data.pca$x[,c(1,2)],col=dense_treatment_groups,pch=16)
# text(data.pca$x[,c(1,2)],labels=groups,pos=3)
# title("PC1 vs PC2 separates HD (high densit) and LD (low density) samples")
# 
# #PC2 vs PC3
# dense_treatment_groups=factor(c("Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD",
#                                 "Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD",
#                                 "Co_HD","Co_HD","Tr_HD","Tr_HD","Co_LD","Co_LD","Tr_LD","Tr_LD"))
# plot(data.pca$x[,c(2,3)],col=dense_treatment_groups,pch=16)
# text(data.pca$x[,c(2,3)],labels=groups,pos=3)
# title('PC2 vs PC3 separates 4 clusters: Control/HD, Control/LD, Treated/HD, Treated/LD')
# 
# #PC1 vs PC3
# #time_groups=factor(c("earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1","earlyG1",
# #                   "lateG1","lateG1","lateG1","lateG1","lateG1","lateG1","lateG1","lateG1",
# #                   "SG2M","SG2M","SG2M","SG2M","SG2M","SG2M","SG2M","SG2M"))
# time_groups=factor(c(1,1,1,1,1,1,1,1,
#                      2,2,2,2,2,2,2,2,
#                      3,3,3,3,3,3,3,3))
# plot(data.pca$x[,c(1,3)],col=dense_treatment_groups,pch = c(16, 17, 18)[as.numeric(time_groups)])
# text(data.pca$x[,c(1,3)],labels=groups,pos=3)
# 
# #PC2 vs PC4
# plot(data.pca$x[,c(2,4)],col=time_groups,pch = 16)
# text(data.pca$x[,c(2,4)],labels=groups,pos=3)
# #title("Component 4 separates samples by cell cycle timepoint, component 2 separates samples by cell density")
# 
# 
# plot(data.pca$x[,c(2,5)],col=time_groups,pch = 16)
# text(data.pca$x[,c(2,5)],labels=groups,pos=3)
# title("PC4 separates samples by cell cycle timepoint; PC3 separates samples by Treated vs Control")
