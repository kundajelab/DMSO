import pandas as pd
import pdb 

data=pd.read_csv("new_RSEM.tpm.corrected",header=0,sep='\t',index_col=[0])
#average replicates 
data['earlyG1.c']=data[['c.earlyG1.1','c.earlyG1.2']].mean(axis=1)
data['earlyG1.t']=data[['t.earlyG1.1','t.earlyG1.2']].mean(axis=1)
data['lateG1.c']=data[['c.lateG1.1','c.lateG1.2']].mean(axis=1)
data['lateG1.t']=data[['t.lateG1.1','t.lateG1.2']].mean(axis=1)
data['SG2M.c']=data[['c.SG2M.1','c.SG2M.2']].mean(axis=1)
data['SG2M.t']=data[['t.SG2M.1','t.SG2M.2']].mean(axis=1)
data=data.drop(['c.earlyG1.1','c.earlyG1.2','t.earlyG1.1','t.earlyG1.2','c.lateG1.1','c.lateG1.2','t.lateG1.1','t.lateG1.2','c.SG2M.1','c.SG2M.2','t.SG2M.1','t.SG2M.2'],axis=1)

#get fold change
import numpy as np 
data[data<0]=0
data['earlyG1.fc']=np.log2(data['earlyG1.t']/(data['earlyG1.c']+.01))
data['lateG1.fc']=np.log2(data['lateG1.t']/(data['lateG1.c']+.01))
data['SG2M.fc']=np.log2(data['SG2M.t']/(data['SG2M.c']+.01))

#extract gene subsets of interst
earlyG1_diff_genes=pd.read_csv("earlyG1.diff.txt",header=None)
lateG1_diff_genes=pd.read_csv("lateG1.diff.txt",header=None)
SG2M_diff_genes=pd.read_csv("SG2M.diff.txt",header=None)

diff_earlyG1_fc=data.loc[earlyG1_diff_genes[0]]['earlyG1.fc']
diff_lateG1_fc=data.loc[lateG1_diff_genes[0]]['lateG1.fc']
diff_SG2M_fc=data.loc[SG2M_diff_genes[0]]['SG2M.fc']

#get mean values for each fold change
all_inf_or_nan = diff_earlyG1_fc.isin([np.inf, -np.inf, np.nan])
diff_earlyG1_fc=diff_earlyG1_fc[~all_inf_or_nan]

all_inf_or_nan = diff_lateG1_fc.isin([np.inf, -np.inf, np.nan])
diff_lateG1_fc=diff_lateG1_fc[~all_inf_or_nan]

all_inf_or_nan = diff_SG2M_fc.isin([np.inf, -np.inf, np.nan])
diff_SG2M_fc=diff_SG2M_fc[~all_inf_or_nan]

#write outputs for plotting and write mean fc values
diff_earlyG1_fc.to_csv('earlyG1.diff.fc',sep='\t')
diff_lateG1_fc.to_csv('lateG1.diff.fc',sep='\t')
diff_SG2M_fc.to_csv('SG2M.diff.fc',sep='\t')

#get the mean fold change for up/down per phase
outf=open("mean_fc_vals.txt",'w')
mean_earlyG1_up=diff_earlyG1_fc[diff_earlyG1_fc>0].mean()
mean_earlyG1_down=diff_earlyG1_fc[diff_earlyG1_fc<0].mean()
mean_lateG1_up=diff_lateG1_fc[diff_lateG1_fc>0].mean()
mean_lateG1_down=diff_lateG1_fc[diff_lateG1_fc<0].mean()
mean_SG2M_up=diff_SG2M_fc[diff_SG2M_fc>0].mean()
mean_SG2M_down=diff_SG2M_fc[diff_SG2M_fc<0].mean()
outf.write("earlyG1.up\t"+str(mean_earlyG1_up)+"\n")
outf.write("earlyG1.down\t"+str(mean_earlyG1_down)+"\n")
outf.write("lateG1.up\t"+str(mean_lateG1_up)+"\n")
outf.write("lateG1.down\t"+str(mean_lateG1_down)+"\n")
outf.write("SG2M.up\t"+str(mean_SG2M_up)+"\n")
outf.write("SG2M.down\t"+str(mean_SG2M_down)+"\n")


