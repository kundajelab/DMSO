import sys
data=open(sys.argv[1],'r').read().strip().split('\n')
thresh=10000
gene_set=set([]) 
outf=open(sys.argv[1]+'.'+str(thresh),'w')
for line in data:
    tokens=line.split('\t') 
    if int(tokens[-1]) < thresh:
        gene_set.add(tokens[0])
gene_set=list(gene_set)
outf.write('\n'.join(gene_set)+'\n')

