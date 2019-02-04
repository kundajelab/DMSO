rm(list=ls())
library(ggplot2)
library(reshape2)
all_stdev=read.table("all_gene_stdev.uncorrected.tsv",header=TRUE,sep='\t')
all_stdev$GENE=NULL
all_stdev[all_stdev>30]=30
diff_stdev=read.table("diff_gene_stdev.uncorrected.tsv",header=TRUE,sep = '\t')
diff_stdev$GENE=NULL
diff_stdev[diff_stdev>30]=30
m_all=melt(all_stdev)
m_diff=melt(diff_stdev)
p1=ggplot(data=m_all,aes(x=m_all$value,fill=m_all$variable))+
  geom_histogram(bins=100,alpha=0.5)+
  geom_vline(xintercept=2.01,color="#e41a1c")+
  geom_vline(xintercept=3.00,color="#377eb8")+
  scale_fill_manual(values=c("#e41a1c","#377eb8"),name="Treatment",labels=c("Control","DMSO"))+
  xlim(0,30)+
  ylim(0,15000)+
  scale_color_manual(values=c("#e41a1c","#377eb8"))+
  xlab("std. dev. TPM across cell cycle phases")+
  ylab("Number of Genes")+
  ggtitle("All Genes\nMean Control=2.01\nMean DMSO=3.00")+
  theme_bw()


p2=ggplot(data=m_diff,aes(x=m_diff$value,fill=m_diff$variable))+
  geom_histogram(bins=100,alpha=0.5)+
  geom_vline(xintercept=2.98,color="#e41a1c")+
  geom_vline(xintercept=4.07,color="#377eb8")+
  xlim(0,30)+
  scale_fill_manual(values=c("#e41a1c","#377eb8"),name="Treatment",labels=c("Control","DMSO"))+
  xlab("std. dev. TPM across cell cycle phases")+
  ylab("Number of Genes")+
  ggtitle("Differential Genes\nMean Control=2.98\nMean DMSO=4.07")+
  theme_bw()

source("~/helpers.R")
multiplot(p1,p2,cols=1)
