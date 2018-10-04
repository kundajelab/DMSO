import sys
import numpy as np
data=open(sys.argv[1],'r').read().strip().split('\n')
outf=open(sys.argv[2],'w') 
for line in data[1::]:
    tokens=line.split('\t')
    if len(tokens)==0:
        continue
    vals=[float(i) for i in tokens]
    #if max(vals)<1:
    #    continue
    c_early=0.5*sum([vals[0],vals[1]])
    t_early=0.5*sum([vals[2],vals[3]])
    c_late=0.5*sum([vals[4],vals[5]])
    t_late=0.5*sum([vals[6],vals[7]])
    c_sg2m=0.5*sum([vals[8],vals[9]])
    t_sg2m=0.5*sum([vals[10],vals[11]])

    outf.write('\t'.join([str(i) for i in [c_early,c_late,c_sg2m,t_early,t_late,t_sg2m]])+'\n')
