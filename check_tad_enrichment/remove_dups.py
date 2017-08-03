data=open('differential_genes.bed','r').read().strip().split('\n')
observed=dict()
outf=open('differential_genes.deduped.bed','w')
for line in data:
    tokens=line.split('\t')
    gene_name =tokens[4]
    if gene_name in observed:
        continue
    else:
        observed[gene_name]=1
        outf.write(line+'\n')
    
