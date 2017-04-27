import numpy as np
#cell-cycle  filtered 
#data=open('macs.fc.rounded.cellcycleonly.tab','r').read().split('\n')
#not cell-cycle filtered
data=open('macs.fc.rounded.tab','r').read().split('\n')

header=data[0].split('\t')
#cell-cycle filtered
#outf=open('macs.fc.rounded.cellcycleonly.averaged.reps.tsv','w')
#not cell-cycle filtered
outf=open('macs.fc.rounded.averaged.reps.tsv','w')
outf.write('Gene\tControl_earlyG1\tControl_lateG1\tControl_SG2M\tDMSO_earlyG1\tDMSO_lateG1\tDMSO_SG2M\tControl_Hues6\tDMSO_Hues6\n')
for line in data[1::]:
    tokens=line.split('\t')
    if len(tokens)==0:
        continue
    gene='\t'.join(tokens[0:4])
    vals=[float(i) for i in tokens[4::] ]
    print(str(vals))
    if max(vals)<1:
        continue
    c_early=0.5*sum([vals[0],vals[1]])
    t_early=0.5*sum([vals[2],vals[3]])
    c_late=0.5*sum([vals[4],vals[5]])
    t_late=0.5*sum([vals[6],vals[7]])
    c_sg2m=0.5*sum([vals[8],vals[9]])
    t_sg2m=0.5*sum([vals[10],vals[11]])
    c_hues6=0.5*sum([vals[12],vals[13]])
    t_hues6=0.5*sum([vals[15],vals[15]]) 

    outf.write(gene+'\t'+'\t'.join([str(i) for i in [c_early,c_late,c_sg2m,t_early,t_late,t_sg2m,c_hues6,t_hues6]])+'\n')
