import numpy as np 
data=open('atacseq_merged.txt','r').read().split('\n')
header=data[0].split('\t')
outf=open('atacseq_merged.averaged.txt','w')
outf.write('Chrom\tStart\tEnd\tControl_earlyG1\tControl_lateG1\tControl_SG2M\tDMSO_earlyG1\tDMSO_lateG1\tDMSO_SG2M\n')
for line in data[1::]:
    tokens=line.split('\t')
    if len(tokens)==0:
        continue
    gene='\t'.join(tokens[0:3])
    vals=[float(i) for i in tokens[3::] ]
    #print(str(vals))
    #if max(vals)<1:
    #    continue 
    c_early=0.5*sum([vals[2],vals[7]])
    t_early=0.5*sum([vals[5],vals[10]])
    c_late=0.5*sum([vals[6],vals[9]])
    t_late=0.5*sum([vals[1],vals[4]])
    c_sg2m=0.5*sum([vals[3],vals[11]])
    t_sg2m=0.5*sum([vals[0],vals[8]])
    outf.write(gene+'\t'+'\t'.join([str(i) for i in [c_early,c_late,c_sg2m,t_early,t_late,t_sg2m]])+'\n')
