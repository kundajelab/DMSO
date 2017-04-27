from collections import OrderedDict 
import sys 
import pdb 
import numpy as np 
inputf=sys.argv[1] 
try:
    data_up=open("up/"+inputf).read().strip().split('\n')
except:
    data_up=None 
try:
    data_down=open("down/"+inputf).read().strip().split('\n')
except: 
    data_down=None 
header=inputf.split('-')[1].split('.')[0] 
#print str(data_up) 
entries=OrderedDict()
total =0 
if data_up != None:  
    for line in data_up: 
        if line.startswith('#'): 
            continue 
        tokens=line.split('\t') 
        var=tokens[0] 
        qvalue=-10*np.log10(float(tokens[3]))
        entries[var]=[qvalue,1] 
        total+=1 
        if total > 20: 
            break 

total=0
if data_down!=None: 
    for line in data_down: 
        if line.startswith('#'): 
            continue 
        tokens=line.split('\t') 
        var=tokens[0] 
        qvalue=-10*np.log10(float(tokens[3]))
        if var in entries: 
            entries[var][1]=qvalue 
        else: 
            entries[var]=[1,qvalue] 
        total+=1 
        if total>20: 
            break; 
outf=open(sys.argv[1]+'.heatmap','w') 
outf.write(header+'\t'+'DMSO Up'+'\t'+'DMSO Down'+'\n')
for var in entries: 
    outf.write(var+'\t'+str(entries[var][0])+'\t'+str(entries[var][1])+'\n')

