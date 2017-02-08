data=open('diffMat_ALLBATCH.csv','r').read().strip().split('\n')
outf=open('diffMat_ALLBATCH.heatmap.inputs.tsv','w')
header=['Region']+data[0].split('\t')[3::]
outf.write('\t'.join(header)+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    region='_'.join(tokens[1:4])
    vals=[float(i) for i in tokens[4::]]
    if(min(vals)==0) and (max(vals)==0):
        continue
    else:
        vals=[str(round(i,3)) for i in vals]
        outf.write(region+'\t'+'\t'.join(vals)+'\n')
        
