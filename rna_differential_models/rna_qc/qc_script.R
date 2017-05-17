rm(list=ls())
library(ggplot2)
library(limma)
library(edgeR)
library(DESeq2)
library(sva)
library(gplots)
#import data 
counts=read.table("rsem.expected_count.tsv",header=TRUE,sep='\t',row.names=1)
counts=round(counts)
all_zero_indices=which(rowSums(counts)==0)
counts=counts[-all_zero_indices,]
rn=rownames(counts)
counts=rlogTransformation(as.matrix(counts))
rownames(counts)=rn

tpm=read.table("rsem.tpm.csv",header=TRUE,sep='\t',row.names=1)
all_zero_indices=which(rowSums(tpm)==0)
tpm=tpm[-all_zero_indices,]
tpm=asinh(tpm)

#get the design matrix 
batches=data.frame(read.table('rnaseq_batches.txt',header=TRUE,sep='\t'))
mod1=model.matrix(~0+Treatment+Timepoint,data=batches)
mod0=model.matrix(~1,data=batches)

#sva on rlog(counts) -- there are 2 surrogate variables 
sva_counts=sva(counts,mod1,mod0)
sva_counts=data.frame(sva_counts$sv)
#batches$sva1=sva_counts$X1
batches$sva2=sva_counts$X2
#add in surrogate variables into the model matrix
#mod2=model.matrix(~0+Sample+sva1+sva2,data=batches)
mod2=model.matrix(~0+Sample+sva2,data=batches)
fit <- lmFit(as.matrix(counts), mod2)
#subtract the SV contribs
#sv_contribs=coefficients(fit)[,c(7,8)] %*% t(fit$design[,c(7,8)])
sv_contribs=coefficients(fit)[,c(7)] %*% t(fit$design[,c(7)])
#counts_corrected=counts-sv_contribs
#try without removing the surrogate variables! 
counts_corrected=na.omit(counts) 

#sva on asinh(tpm)
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


#heatmaps of cell-cycle genes before & after sva 
cc_genes=as.vector(read.table("cell_cycle_genes.txt",header=FALSE)$V1)

counts=as.data.frame(counts)
counts_corrected=na.omit(as.data.frame(counts_corrected))

tpm_cc=na.omit(tpm[cc_genes,])
rn=rownames(tpm_cc)
tpm_cc=data.frame(earlyG1_control=rowMeans(cbind(tpm_cc$c.earlyG1.r1,tpm_cc$c.earlyG1.r2)),
                  lateG1_control=rowMeans(cbind(tpm_cc$c.lateG1.r1,tpm_cc$c.lateG1.r2)),
                  SG2M_control=rowMeans(cbind(tpm_cc$c.SG2M.r1,tpm_cc$c.SG2M.r2)),
                  earlyG1_treated=rowMeans(cbind(tpm_cc$t.earlyG1.r1,tpm_cc$t.earlyG1.r2)),
                  lateG1_treated=rowMeans(cbind(tpm_cc$t.lateG1.r1,tpm_cc$t.lateG1.r2)),
                  SG2M_treated=rowMeans(cbind(tpm_cc$t.SG2M.r1,tpm_cc$t.SG2M.r2)))
rownames(tpm_cc)=rn

counts_cc=na.omit(counts[cc_genes,])
rn=rownames(counts_cc)
counts_cc=data.frame(earlyG1_control=rowMeans(cbind(counts_cc$c.earlyG1.r1,counts_cc$c.earlyG1.r2)),
                  lateG1_control=rowMeans(cbind(counts_cc$c.lateG1.r1,counts_cc$c.lateG1.r2)),
                  SG2M_control=rowMeans(cbind(counts_cc$c.SG2M.r1,counts_cc$c.SG2M.r2)),
                  earlyG1_treated=rowMeans(cbind(counts_cc$t.earlyG1.r1,counts_cc$t.earlyG1.r2)),
                  lateG1_treated=rowMeans(cbind(counts_cc$t.lateG1.r1,counts_cc$t.lateG1.r2)),
                  SG2M_treated=rowMeans(cbind(counts_cc$t.SG2M.r1,counts_cc$t.SG2M.r2)))
rownames(counts_cc)=rn

counts_corrected_cc=na.omit(counts_corrected[cc_genes,])
rn=rownames(counts_corrected_cc)
counts_corrected_cc=data.frame(earlyG1_control=rowMeans(cbind(counts_corrected_cc$c.earlyG1.r1,counts_corrected_cc$c.earlyG1.r2)),
                               lateG1_control=rowMeans(cbind(counts_corrected_cc$c.lateG1.r1,counts_corrected_cc$c.lateG1.r2)),
                               SG2M_control=rowMeans(cbind(counts_corrected_cc$c.SG2M.r1,counts_corrected_cc$c.SG2M.r2)),
                               earlyG1_treated=rowMeans(cbind(counts_corrected_cc$t.earlyG1.r1,counts_corrected_cc$t.earlyG1.r2)),
                               lateG1_treated=rowMeans(cbind(counts_corrected_cc$t.lateG1.r1,counts_corrected_cc$t.lateG1.r2)),
                               SG2M_treated=rowMeans(cbind(counts_corrected_cc$t.SG2M.r1,counts_corrected_cc$t.SG2M.r2)))
rownames(counts_corrected_cc)=rn

tpm_corrected_cc=na.omit(tpm_corrected[cc_genes,])
rn=rownames(tpm_corrected_cc)
tpm_corrected_cc=data.frame(earlyG1_control=rowMeans(cbind(tpm_corrected_cc$c.earlyG1.r1,tpm_corrected_cc$c.earlyG1.r2)),
                     lateG1_control=rowMeans(cbind(tpm_corrected_cc$c.lateG1.r1,tpm_corrected_cc$c.lateG1.r2)),
                     SG2M_control=rowMeans(cbind(tpm_corrected_cc$c.SG2M.r1,tpm_corrected_cc$c.SG2M.r2)),
                     earlyG1_treated=rowMeans(cbind(tpm_corrected_cc$t.earlyG1.r1,tpm_corrected_cc$t.earlyG1.r2)),
                     lateG1_treated=rowMeans(cbind(tpm_corrected_cc$t.lateG1.r1,tpm_corrected_cc$t.lateG1.r2)),
                     SG2M_treated=rowMeans(cbind(tpm_corrected_cc$t.SG2M.r1,tpm_corrected_cc$t.SG2M.r2)))
rownames(tpm_corrected_cc)=rn


#average reps 

heatmap.2(as.matrix(counts_cc),
          Colv=FALSE,
          Rowv=FALSE,
          col=redgreen(30),
          scale="row",
          trace="none",
          dendrogram = "none",
          margins=c(10,10),
          cexRow = 0.5,
          cexCol=0.8,
          main="rlog(counts)")


heatmap.2(as.matrix(tpm_cc),
          Colv=FALSE,
          Rowv=FALSE,
          col=redgreen(30),
          scale="row",
          trace="none",
          dendrogram = "none",
          margins=c(10,10),
          cexRow = 0.5,
          cexCol=0.8,
          main="asinh(tpm)")


heatmap.2(as.matrix(counts_corrected_cc),
          Colv=FALSE,
          Rowv=FALSE,
          col=redgreen(30),
          scale="row",
          trace="none",
          dendrogram = "none",
          margins=c(10,10),
          cexRow = 0.5,
          cexCol=0.8,
          main="rlog(counts)- surr. var.")

heatmap.2(as.matrix(tpm_corrected_cc),
          Colv=FALSE,
          Rowv=FALSE,
          col=redgreen(30),
          scale="row",
          trace="none",
          dendrogram = "none",
          margins=c(10,10),
          cexRow = 0.5,
          cexCol=0.8,
          main="asinh(tpm)- surr. var.")

#cdf of rlog data & asinh(tpm) before & after sva 
library(ggplot2)
source('helpers.R')
colors1 <- c('c.earlyG1'= "red",
             'c.lateG1' = "black",
             'c.SG2M' = "blue",
             "t.earlyG1"="green",
             "t.lateG1"="orange",
             "t.SG2M"="purple")
counts=as.data.frame(counts)
p1=ggplot(counts)+
  stat_ecdf(aes(c.earlyG1.r1,colour="c.earlyG1"))+
  stat_ecdf(aes(c.earlyG1.r2,colour="c.earlyG1"))+
  stat_ecdf(aes(c.lateG1.r1,colour="c.lateG1"))+
  stat_ecdf(aes(c.lateG1.r2,colour="c.lateG1"))+
  stat_ecdf(aes(c.SG2M.r1,colour="c.SG2M"))+
  stat_ecdf(aes(c.SG2M.r2,colour="c.SG2M"))+
  stat_ecdf(aes(t.earlyG1.r1,colour="t.earlyG1"))+
  stat_ecdf(aes(t.earlyG1.r2,colour="t.earlyG1"))+
  stat_ecdf(aes(t.lateG1.r1,colour="t.lateG1"))+
  stat_ecdf(aes(t.lateG1.r2,colour="t.lateG1"))+
  stat_ecdf(aes(t.SG2M.r1,colour="t.SG2M"))+
  stat_ecdf(aes(t.SG2M.r2,colour="t.SG2M"))+
  scale_colour_manual(name="Sample",
                      values=colors1)+
  theme_bw(20)+
  ylim(c(0,1))+
  xlim(c(0,20))+
  xlab("RLOG(counts)")+
  ylab("CDF")+
  ggtitle("RNASeq distribution")

p2=ggplot(tpm)+
  stat_ecdf(aes(c.earlyG1.r1,colour="c.earlyG1"))+
  stat_ecdf(aes(c.earlyG1.r2,colour="c.earlyG1"))+
  stat_ecdf(aes(c.lateG1.r1,colour="c.lateG1"))+
  stat_ecdf(aes(c.lateG1.r2,colour="c.lateG1"))+
  stat_ecdf(aes(c.SG2M.r1,colour="c.SG2M"))+
  stat_ecdf(aes(c.SG2M.r2,colour="c.SG2M"))+
  stat_ecdf(aes(t.earlyG1.r1,colour="t.earlyG1"))+
  stat_ecdf(aes(t.earlyG1.r2,colour="t.earlyG1"))+
  stat_ecdf(aes(t.lateG1.r1,colour="t.lateG1"))+
  stat_ecdf(aes(t.lateG1.r2,colour="t.lateG1"))+
  stat_ecdf(aes(t.SG2M.r1,colour="t.SG2M"))+
  stat_ecdf(aes(t.SG2M.r2,colour="t.SG2M"))+
  scale_colour_manual(name="Sample",
                      values=colors1)+
  theme_bw(20)+
  ylim(c(0,1))+
  xlim(c(0,20))+
  xlab("asinh(tpm)")+
  ylab("CDF")+
  ggtitle("RNASeq distribution")

p3=ggplot(counts_corrected)+
  stat_ecdf(aes(c.earlyG1.r1,colour="c.earlyG1"))+
  stat_ecdf(aes(c.earlyG1.r2,colour="c.earlyG1"))+
  stat_ecdf(aes(c.lateG1.r1,colour="c.lateG1"))+
  stat_ecdf(aes(c.lateG1.r2,colour="c.lateG1"))+
  stat_ecdf(aes(c.SG2M.r1,colour="c.SG2M"))+
  stat_ecdf(aes(c.SG2M.r2,colour="c.SG2M"))+
  stat_ecdf(aes(t.earlyG1.r1,colour="t.earlyG1"))+
  stat_ecdf(aes(t.earlyG1.r2,colour="t.earlyG1"))+
  stat_ecdf(aes(t.lateG1.r1,colour="t.lateG1"))+
  stat_ecdf(aes(t.lateG1.r2,colour="t.lateG1"))+
  stat_ecdf(aes(t.SG2M.r1,colour="t.SG2M"))+
  stat_ecdf(aes(t.SG2M.r2,colour="t.SG2M"))+
  scale_colour_manual(name="Sample",
                      values=colors1)+
  theme_bw(20)+
  ylim(c(0,1))+
  xlim(c(0,20))+
  xlab("rlog(counts)-sv")+
  ylab("CDF")+
  ggtitle("RNASeq distribution")

p4=ggplot(tpm_corrected)+
  stat_ecdf(aes(c.earlyG1.r1,colour="c.earlyG1"))+
  stat_ecdf(aes(c.earlyG1.r2,colour="c.earlyG1"))+
  stat_ecdf(aes(c.lateG1.r1,colour="c.lateG1"))+
  stat_ecdf(aes(c.lateG1.r2,colour="c.lateG1"))+
  stat_ecdf(aes(c.SG2M.r1,colour="c.SG2M"))+
  stat_ecdf(aes(c.SG2M.r2,colour="c.SG2M"))+
  stat_ecdf(aes(t.earlyG1.r1,colour="t.earlyG1"))+
  stat_ecdf(aes(t.earlyG1.r2,colour="t.earlyG1"))+
  stat_ecdf(aes(t.lateG1.r1,colour="t.lateG1"))+
  stat_ecdf(aes(t.lateG1.r2,colour="t.lateG1"))+
  stat_ecdf(aes(t.SG2M.r1,colour="t.SG2M"))+
  stat_ecdf(aes(t.SG2M.r2,colour="t.SG2M"))+
  scale_colour_manual(name="Sample",
                      values=colors1)+
  theme_bw(20)+
  ylim(c(0,1))+
  xlim(c(0,20))+
  xlab("asinh(tpm)-sv")+
  ylab("CDF")+
  ggtitle("RNASeq distribution")

multiplot(p1,p2,p3,p4,cols=2)
common=intersect(rownames(counts_corrected),rownames(tpm_corrected))
tpm_corrected=tpm_corrected[common,]
counts_corrected=counts_corrected[common,]
#tpm_corrected=tpm_corrected[rownames(counts_corrected),]
#counts_corrected=counts_corrected[rownames(tpm_corrected),]
#rank, volcano, venn 
mod_final=model.matrix(~0+Sample,data=batches)
fit_counts <- lmFit(counts_corrected, mod_final)
fit_tpm <-lmFit(tpm_corrected,mod_final)
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
                          levels=mod_final)
limma_coefs=seq(9)
comparison_names=c("earlyG1",
                   "lateG1",
                   "SG2M",
                   "lateG1_vs_earlyG1_t",
                   "SG2M_vs_lateG1_t",
                   "earlyG1_vs_SG2M_t",
                   "lateG1_vs_earlyG1_c",
                   "SG2M_vs_lateG1_c",
                   "earlyG1_vs_GS2M_c")

#USE LIMMA ANALYSIS
fit_counts=contrasts.fit(fit_counts,cont.matrix)
e_counts=eBayes(fit_counts)
fit_tpm=contrasts.fit(fit_tpm,cont.matrix)
e_tpm=eBayes(fit_tpm)

for(contrast_index in seq(1,9))
{
  comparison_name=unlist(comparison_names[contrast_index])
  la_counts=topTable(e_counts,number=nrow(counts_corrected),coef=contrast_index)
  la_tpm=topTable(e_tpm,number=nrow(tpm_corrected),coef=contrast_index)
  la_counts$Gene=rownames(la_counts)
  la_tpm$Gene=rownames(la_tpm)
  # la_counts=la_counts[with(la_counts,order(Gene)),]
  # la_tpm=la_tpm[with(la_tpm,order(Gene)),]
  # png(paste("ranks",comparison_name,"png",sep="."))
  # par(mfrow=c(1,2))
  # smoothScatter(rank(la_counts$adj.P.Val),
  #               rank(la_tpm$adj.P.Val),
  #               xlab="rlog(counts)",
  #               ylab="asinh(tpm)",
  #               main=paste("Ranks adj.P.Val",comparison_name))
  # smoothScatter(rank(la_counts$logFC),
  #               rank(la_tpm$logFC),
  #               xlab="rlog(counts)",
  #               ylab="asinh(tpm)",
  #               main=paste("Ranks logFC",comparison_name))
  # dev.off() 
  # png(paste("pval_and_log",comparison_name,"png",sep="."))
  # par(mfrow=c(1,2))
  # smoothScatter(-10*log10(la_counts$adj.P.Val),
  #               -10*log10(la_tpm$adj.P.Val),
  #               xlab="rlog(counts)",
  #               ylab="asinh(tpm)",
  #               main=paste("-10*log10(adj.P.Val)",comparison_name))
  # smoothScatter(la_counts$logFC,
  #               la_tpm$logFC,
  #               xlab="rlog(counts)",
  #               ylab="asinh(tpm)",
  #               main=paste("logFC",comparison_name))
  # dev.off() 
  
  #venn diagram
  la_counts_sig=(abs(la_counts$logFC)>0.5 & la_counts$adj.P.Val<0.1)
  la_tpm_sig=(abs(la_tpm$logFC)>1 & la_tpm$adj.P.Val<0.05)
  sigvals=data.frame(la_counts_sig,la_tpm_sig)
  names(sigvals)=c("rlog_counts","asinh_tpm")
  png(paste("venn",comparison_name,"png",sep='.'))
  vennDiagram(sigvals,circle.col = c("red", "blue"),main=comparison_name)
  dev.off()
  
  
  lfc_and_pval_sig=rownames(la_tpm[la_tpm$adj.P.Val<=0.05 & abs(la_tpm$logFC)>=1,])
  lfc_sig=rownames(la_tpm[la_tpm$adj.P.Val>0.05 & abs(la_tpm$logFC)>=1,])
  pval_sig=rownames(la_tpm[la_tpm$adj.P.Val<=0.05 & abs(la_tpm$logFC)<1,])
 
  la_counts=as.data.frame(la_counts)
  la_counts$color=rep("Insignificant",nrow(la_counts))
  la_counts[lfc_and_pval_sig,"color"]="asinh(tpm) FDR<0.1,abs(LFC)>1"
  la_counts[lfc_sig,"color"]="asinh(tpm) abs(LFC)>1"
  la_counts[pval_sig,"color"]="asinh(tpm) FDR<0.1"
  p1=ggplot(data=la_counts,aes(x=la_counts$logFC,y=-10*log10(la_counts$adj.P.Val),color=factor(la_counts$color)))+
    geom_point(size=0.5,alpha=0.5)+
    geom_hline(aes(yintercept=-10*log10(0.1)))+
    geom_vline(aes(xintercept=-0.5))+
    geom_vline(aes(xintercept=0.5))+
    xlab("log2(fc)")+
    ylab("-10*log10(FDR)")+
    scale_color_manual(name="Category",
                       values=c("black","red","green","orange"))+
    ggtitle(paste("rlog_counts",comparison_name))
  
  la_tpm=as.data.frame(la_tpm)
  la_tpm$color=rep("Insignificant",nrow(la_tpm))
  la_tpm[lfc_and_pval_sig,"color"]="asinh(tpm) FDR<0.05,abs(LFC)>1"
  la_tpm[lfc_sig,"color"]="asinh(tpm) abs(LFC)>1"
  la_tpm[pval_sig,"color"]="asinh(tpm) FDR<0.05"
  
  p2=ggplot(data=la_tpm,aes(x=la_tpm$logFC,y=-10*log10(la_tpm$adj.P.Val),color=la_tpm$color))+
    geom_point(size=0.5,alpha=0.5)+
    xlab("log2(fc)")+
    ylab("-10*log10(FDR)")+
    geom_hline(aes(yintercept=-10*log10(0.05)))+
    geom_vline(aes(xintercept=-1))+
    geom_vline(aes(xintercept=1))+
    scale_color_manual(name="Category",
                       values=c("black","red","green","orange"))+
    ggtitle(paste("asinh_tpm",comparison_name))
  png(paste("volcano",comparison_name,"png",sep="."),width=10,height=5,units='in',res=300)
  multiplot(p1,p2,cols=2)
  dev.off() 
  
}