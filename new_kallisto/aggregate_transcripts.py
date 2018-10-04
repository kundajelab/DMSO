#sums across transcripts for a gene
# removes extra transcript name column
data=open("kallisto.with.gene.name.tpm",'r').read().strip().split('\n')
outf=open("kallisto.genes.txt",'w')
header=data[0].split('\t')
outf.write("Gene\t"+'\t'.join(header[3::])+'\n')
gene_dict=dict()
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[1]
    values=[float(i) for i in tokens[3::]]
    if gene not in gene_dict:
        gene_dict[gene]=values
    else:
        current_sum=gene_dict[gene]
        new_sum=[x+y for x,y in zip(current_sum,values)]
        gene_dict[gene]=new_sum
print("generated sum of gene transcripts")
for gene in gene_dict:
    outf.write(gene+'\t'+'\t'.join([str(i)for i in gene_dict[gene]])+'\n')
    
