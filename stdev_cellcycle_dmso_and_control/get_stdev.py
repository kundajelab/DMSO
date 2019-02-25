import pandas as pd
import pdb 

#data=pd.read_csv("new_RSEM.tpm.corrected",header=0,sep='\t',index_col=[0])
data=pd.read_csv("rsem.genes.tpm",header=0,sep='\t',index_col=[0])


#average replicates 
data['earlyG1.c']=data[['c.earlyG1.1','c.earlyG1.2']].mean(axis=1)
data['earlyG1.t']=data[['t.earlyG1.1','t.earlyG1.2']].mean(axis=1)
data['lateG1.c']=data[['c.lateG1.1','c.lateG1.2']].mean(axis=1)
data['lateG1.t']=data[['t.lateG1.1','t.lateG1.2']].mean(axis=1)
data['SG2M.c']=data[['c.SG2M.1','c.SG2M.2']].mean(axis=1)
data['SG2M.t']=data[['t.SG2M.1','t.SG2M.2']].mean(axis=1)
data=data.drop(['c.earlyG1.1','c.earlyG1.2','t.earlyG1.1','t.earlyG1.2','c.lateG1.1','c.lateG1.2','t.lateG1.1','t.lateG1.2','c.SG2M.1','c.SG2M.2','t.SG2M.1','t.SG2M.2'],axis=1)

#get stdev control and DMSO
import numpy as np
data['control_std']=data[['earlyG1.c','lateG1.c','SG2M.c']].std(axis=1)
data['dmso_std']=data[['earlyG1.t','lateG1.t','SG2M.t']].std(axis=1)
data=data.drop(["earlyG1.c","lateG1.c","SG2M.c","earlyG1.t","lateG1.t","SG2M.t"],axis=1)

#subset to differential genes
#extract gene subsets of interst
diff_genes=pd.read_csv("diff_genes",header=None)
std_diff=data.loc[diff_genes[0]]

#data.to_csv("all_gene_stdev.tsv",sep='\t')
#std_diff.to_csv("diff_gene_stdev.tsv",sep='\t')
data.to_csv("all_gene_stdev.uncorrected.tsv",sep='\t')
std_diff.to_csv("diff_gene_stdev.uncorrected.tsv",sep='\t')

print("all data:")
print(data.mean())
print("diff genes:")
print(std_diff.mean())
