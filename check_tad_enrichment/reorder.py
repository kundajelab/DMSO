order=open('tmp2','r').read().strip().split('\n')
data=open('gene_summary.df','r').read().strip().split('\n')
indices=[]
header=data[0].split('\t')
for entry in order:
    indices.append(header.index(entry))
outf=open('tmp','w')
for line in data:
    tokens=line.split('\t')
    reordered=[tokens[i] for i in indices]
    outf.write('\t'.join(reordered)+'\n')
    
