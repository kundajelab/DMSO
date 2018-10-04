rm(list=ls())
library(ggplot2)
library(limma)

rsem=read.table('new_RSEM.tpm.corrected',header=TRUE,sep='\t',row.names=1)
kallisto=read.table('new_Kallisto.tpm.corrected',header=TRUE,sep='\t',row.names=1)

#rsem=read.table('../new_RSEM/rsem.genes.tpm',header=TRUE,sep='\t',row.names=1)
#kallisto=read.table('../new_kallisto/kallisto.genes.txt',header=TRUE,sep='\t',row.names=1)
names(kallisto)=names(rsem)


batches=read.table("rnaseq_batches.txt",header = TRUE,sep='\t')
mod=model.matrix(~0+Sample,data=batches)
fit_rsem =lmFit(rsem,mod)
fit_kallisto=lmFit(kallisto,mod)

#specify the contrasts
cont.matrix=makeContrasts(earlyg1_dmso_control="Samplet.earlyG1-Samplec.earlyG1",
                          lateg1_dmso_control="Samplet.lateG1-Samplec.lateG1",
                          sg2m_dmso_control="Samplet.SG2M-Samplec.SG2M",
                          levels=mod)
limma_coefs=seq(3)
comparison_names=c("earlyG1",
                   "lateG1",
                   "SG2M")

#USE LIMMA ANALYSIS
fit_rsem=contrasts.fit(fit_rsem,cont.matrix)
fit_kallisto=contrasts.fit(fit_kallisto,cont.matrix)
e_rsem=eBayes(fit_rsem)
e_kallisto=eBayes(fit_kallisto)
for(contrast_index in seq(1,3))
{
  comparison_name=unlist(comparison_names[contrast_index])
  rsem_table=topTable(e_rsem,number=nrow(e_rsem),coef=contrast_index)
  kallisto_table=topTable(e_kallisto,number=nrow(e_kallisto),coef=contrast_index)
  #merge the tables for plotting by p-value 
  rsem_table$Gene=rownames(rsem_table)
  kallisto_table$Gene=rownames(kallisto_table)
  merged=merge(kallisto_table,rsem_table,by.x="Gene",by.y="Gene")
  kallisto_pval=-10*log10(merged$P.Value.x)
  rsem_pval=-10*log10(merged$adj.P.Val.y)
  toplot=data.frame(kallisto_pval,rsem_pval)
  spearman_cor=round(cor(kallisto_pval,rsem_pval,method="spearman"),3)
  pearson_cor=round(cor(kallisto_pval,rsem_pval,method="pearson"),3)
  
  p=ggplot(data=toplot,aes(x=kallisto_pval,y=rsem_pval))+
    geom_point(alpha=0.3)+
    xlab("Kallisto -10*log10(adj.p.val)")+
    ylab("RSEM -10*log10(adj.p.val)")+
    ggtitle(paste(comparison_name," spearman=",spearman_cor," peason=",pearson_cor,sep=""))
}
