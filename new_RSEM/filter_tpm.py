genes_to_use=open('genes_to_use','r').read().strip().split('\n')
gene_dict=dict()
for gene in genes_to_use:
    gene_dict[gene]=1 
data=open('rsem.genes.tpm','r').read().strip().split('\n')
outf=open('rsem.genes.tpm.filtered','w')
for line in data:
    tokens=line.split('\t')
    gene=tokens[0]
    if gene in gene_dict:
        outf.write(line+'\n')
        
