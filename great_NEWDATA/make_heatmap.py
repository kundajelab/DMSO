from os import listdir
from os.path import isfile, join
import math 
mypath="/srv/scratch/annashch/dmso/great_NEWDATA/"
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
alldata=dict() 
allfiles=[] 
for f in onlyfiles: 
    if f.endswith('GREAT.tsv'): 
        truncated=f.replace('_GREAT.tsv','')
        truncated=truncated.replace('R1','Dense') 
        truncated=truncated.replace('R2','LowDens.') 
        allfiles.append(truncated) 
        print str(truncated) 
        data=open(f,'r').read().strip().split('\n') 
        for line in data[2::]: 
            tokens=line.split('\t') 
            category=tokens[0] 
            name=tokens[1] 
            fdr=tokens[4] 
            if category not in alldata: 
                alldata[category]=dict() 
            if name not in alldata[category]:
                alldata[category][name]=dict() 
            alldata[category][name][truncated]=fdr 

#write all to file 
allfiles.sort() 
for category in alldata: 
    outf=open(category.replace(' ','_'),'w')
    outf.write('Result\t'+'\t'.join(allfiles)+'\n') 
    for name in alldata[category]: 
        outf.write(name) 
        for fname in allfiles: 
            if fname in alldata[category][name]: 
                outf.write('\t'+str(round(-10*math.log(float(alldata[category][name][fname]),10),3)))
            else: 
                outf.write('\t0') 
        outf.write('\n') 

