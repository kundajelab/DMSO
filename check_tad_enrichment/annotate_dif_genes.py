gene_names=open('diff_gene_names.txt','r').read().strip().split('\n')
annotations=open('../gene_coords.txt','r').read().strip().split('\n')
outf=open('differential_genes.bed','w')
annotation_dict=dict()
for line in annotations:
    tokens=line.split('\t')
    gene_name=tokens[-1]
    annotation_dict[gene_name]=line
for gene in gene_names:
    outf.write(annotation_dict[gene]+'\n')
    
