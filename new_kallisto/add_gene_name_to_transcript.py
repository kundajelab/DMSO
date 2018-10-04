import pandas as pd
import pdb 
data=open("kallisto.tpm",'r').read().strip().split('\n')
mapped=pd.read_csv("grch38.ensembltranscriptid.to.name",header=0,sep='\t',index_col=0)
outf=open("kallisto.with.gene.name.tpm",'w')
header=data[0].split('\t')
outf.write(header[0]+'\t'+'Gene'+'\t'+'\t'.join(header[1::])+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    transcript=tokens[0]
    genename=mapped.loc[transcript][0].split('-')[0]
    outf.write(transcript+'\t'+genename+'\t'+'\t'.join(tokens[1::])+'\n')

