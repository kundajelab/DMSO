data=open('macs.fc.tab','r').read().strip().split('\n')
sizes=open('../ppr.merged.bed','r').read().strip().split('\n')
outf=open('macs.fc.averaged.tab','w')
outf.write(data[0]+'\n')
for i in range(1,len(data)):
    tokens=[float(j) for j in data[i].split('\t')]
    regionsize=[float(j) for j in sizes[i-1].split('\t')[1::]]
    extent=regionsize[1]-regionsize[0]+1
    tokens=[round(j/extent,2) for j in tokens]
    outf.write('\t'.join([str(j) for j in tokens])+'\n')
    
    
