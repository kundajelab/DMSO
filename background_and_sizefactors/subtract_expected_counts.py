import pandas as pd
import pdb
data=pd.read_table("atac.counts.txt",header=0,sep='\t')
header=[str(i) for i in data.columns]
b=pd.read_table("b.txt",header=0,sep='\t')
outf=open("background_subtracted.txt",'w')
outf.write('\t'.join(header)+'\n')
for i in range(data.shape[0]):
    try:
        expected_reads=b.transpose()*(data.iloc[i]["End"]-data.iloc[i]["Start"])
        corrected_row=(data.iloc[i][3::]-expected_reads.transpose()).as_matrix().squeeze()
        corrected_row=[str(int(round(j))) for j in corrected_row]
        outf.write(data.iloc[i][0]+'\t'+str(data.iloc[i][1])+'\t'+str(data.iloc[i][2])+'\t'+'\t'.join(corrected_row)+'\n')
    except:
        pdb.set_trace() 
