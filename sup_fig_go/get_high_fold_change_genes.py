#calculate genes w/ tpm >1 in at least one column 
#calculates genes with fold change > 2 between DMSO & Control
import sys
data=open(sys.argv[1],'r').read().strip().split('\n') 
outf1=open(sys.argv[1]+'.tpm.gt1','w')
outf2=open(sys.argv[1]+'.tpm.gt1.fc.gt2','w')
header=data[0]
outf1.write(header+'\n')
outf2.write(header+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    vals=[float(i) for i in tokens[1::]]
    if max(vals)>1:
        outf1.write(line+'\n')
        ratios=[] 
        try:
            if ((vals[3]>1) or (vals[0]>1)):
                ratios.append(vals[3]/vals[0])
        except:
            continue
        try:
            if ((vals[4]>1) or (vals[1]>1)):
                ratios.append(vals[4]/vals[1])
        except:
            continue
        try:
            if ((vals[5]>1) or (vals[2]>1)):
                ratios.append(vals[5]/vals[2])
        except:
            continue
        try:
            if ((vals[3]>1) or (vals[0]>1)):
                ratios.append(vals[0]/vals[3])
        except:
            continue
        try:
            if ((vals[1]>1) or (vals[4]>1)):
                ratios.append(vals[1]/vals[4])
        except:
            continue
        try:
            if ((vals[5]>1) or (vals[2]>1)):
                ratios.append(vals[5]/vals[2])
        except:
            continue
        if max(ratios) > 2:
            outf2.write(line+'\n')
            
