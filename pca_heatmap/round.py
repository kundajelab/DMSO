data=open('macs.fc.tab','r').read().strip().split('\n')
outf=open('macs.fc.rounded.tab','w')
outf.write(data[0]+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    tokens=[round(float(i),2) for i in tokens]
    tokens=[str(i) for i in tokens]
    outf.write('\t'.join(tokens)+'\n')
    
