genes=open('differentiation_genes.gtf','r').read().strip().split('\n')
gene_dict=dict()
for line in genes:
    tokens=line.split('\t')
    chrom=tokens[0]
    start=int(tokens[1])
    end=int(tokens[2])
    name=tokens[3]
    gene_dict[name]=[chrom,start,end]
print("made gene dict!")
#atac_peaks=open("macs.fc.averaged.cellcycleonly.ld.averaged.tab",'r').read().strip().split('\n')
atac_peaks=open("atacseq_merged.averaged.txt",'r').read().strip().split('\n')
print('gene\t'+atac_peaks[0])
for line in atac_peaks[1::]:
    tokens=line.split('\t')
    chrom=tokens[0]
    start=int(tokens[1])
    for gene in gene_dict:
        gene_chrom=gene_dict[gene][0]
        gene_start=gene_dict[gene][1]
        if gene_chrom==chrom:
            if abs(start-gene_start)< 5000:
                print(gene+'\t'+line)
                break

