import numpy as np 
data=open('macs.fc.ld.atac.cellcycleonly.tab','r').read().split('\n')
header=data[0].split('\t')
outf=open('macs.fc.ld.atac.cellcycleonly.foldchange.tab','w')
outf.write('GeneAssoc\tearlyG1\tlateG1\tSG2M\n')
for line in data[1::]:
    tokens=line.split('\t')
    print(str(tokens[4::]))
    if len(tokens)==0:
        continue
    gene=tokens[3]
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
    if c_early==0:
        fc_early=t_early
    elif t_early==0:
        fc_early=0 
    else:
        fc_early=np.log2(t_early/c_early)
    if c_late==0:
        fc_late=t_late
    elif t_late==0:
        fc_late=0 
    else:
        fc_late=np.log2(t_late/c_late)
    if c_sg2m==0:
        fc_sg2m=t_sg2m
    elif t_sg2m==0:
        fc_sg2m=0 
    else:
        fc_sg2m=np.log2(t_sg2m/c_sg2m)
    '''
    if ((fc_early < 1) and (fc_early !=0)):
        fc_early=-1*(1/fc_early)
    if ((fc_late < 1) and (fc_late!=0)):
        fc_late=-1*(1/fc_late)
    if ((fc_sg2m < 1) and (fc_sg2m!=0)):
        fc_sg2m=-1*(1/fc_sg2m)
    '''
    maxfc=max([fc_early,fc_late,fc_sg2m])
    minfc=min([fc_early,fc_late,fc_sg2m])
    if (maxfc >= 2) or ((minfc <=0.5) and (minfc >0)):
        #significant!!
        outf.write(gene+'\t'+str(round(fc_early,2))+'\t'+str(round(fc_late,2))+'\t'+str(round(fc_sg2m,2))+'\n')
        
