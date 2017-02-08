import sys 
h3k27ac_file=open('chip_seq/h3k27ac.naiveoverlap.geneassoc.bed','r').read().strip().split('\n')
h3k27me3_file=open('chip_seq/h3k27me3.naiveoverlap.geneassoc.bed','r').read().strip().split('\n')
h3k4me3_file=open('chip_seq/h3k4me3.naiveoverlap.geneassoc.bed','r').read().strip().split('\n')
rna_file=open(sys.argv[1],'r').read().strip().split('\n') 
atac_file=open(sys.argv[2],'r').read().strip().split('\n')
outf=open(sys.argv[3],'w')
outf.write('Gene\tRNA\tATAC\tH3K27ac\tH3K27me3\tH3K4me3\n')
gene_dict=dict()
for line in h3k27ac_file:
    gene_val=line.split('\t')[3]
    gene_name=gene_val.split(' ')[0]
    if gene_name not in gene_dict:
        gene_dict[gene_name]=['h3k27ac']
    else:
        gene_dict[gene_name].append('h3k27ac')
for line in h3k27me3_file:
    gene_val=line.split('\t')[3]
    gene_name=gene_val.split(' ')[0]
    if gene_name not in gene_dict:
        gene_dict[gene_name]=['h3k27me3']
    else:
        gene_dict[gene_name].append('h3k27me3')
for line in h3k4me3_file:
    gene_val=line.split('\t')[3]
    gene_name=gene_val.split(' ')[0]
    if gene_name not in gene_dict:
        gene_dict[gene_name]=['h3k4me3']
    else:
        gene_dict[gene_name].append('h3k4me3')
for line in rna_file[1::]:
    tokens=line.split('\t')
    gene_name=tokens[0]
    if gene_name not in gene_dict:
        gene_dict[gene_name]=['rna']
    else:
        gene_dict[gene_name].append('rna')
for line in atac_file[1::]:
    tokens=line.split('\t')
    gene_name=tokens[0].split(' ')[0] 
    if gene_name not in gene_dict:
        gene_dict[gene_name]=['atac']
    else:
        gene_dict[gene_name].append('atac')
for gene in gene_dict:
    outf.write(gene)
    if 'rna' in gene_dict[gene]:
        outf.write('\t1')
    else:
        outf.write('\t0')
    if 'atac' in gene_dict[gene]:
        outf.write('\t1')
    else:
        outf.write('\t0')
    if 'h3k27ac' in gene_dict[gene]:
        outf.write('\t1')
    else:
        outf.write('\t0')
    if 'h3k27me3' in gene_dict[gene]:
        outf.write('\t1')
    else:
        outf.write('\t0')
    if 'h34me3' in gene_dict[gene]:
        outf.write('\t1')
    else:
        outf.write('\t0')
    outf.write('\n')

