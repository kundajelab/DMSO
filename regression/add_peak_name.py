data=open('dmso.regression.labels','r').read().strip().split('\n') 
outf=open('dmso.regression.labels.named','w') 
outf.write('Chrom\tStart\tEnd\tPeak\tControl\tDMSO\tDMSO.Control\n')
i=0 
for line in data: 
    tokens=line.split('\t') 
    outf.write('\t'.join(tokens[0:3])+'\t'+'peak_'+str(i)+'\t'+str('\t'.join(tokens[3::]))+'\n')
    i+=1
