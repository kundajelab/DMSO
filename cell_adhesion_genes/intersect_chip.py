genes=open('celladhesion_genes.gtf','r').read().strip().split('\n')
outf=open('chip.hits','w')
outf.write('Gene_Chrom_Start_End\tH3K27ac_control\tH3K27ac_DMSO\tH3K4me3_Control\tH3K4me3_DMSO\tH3K27me3_Control\tH3K27me3_DMSO\n')
gene_dict=dict()
for line in genes:
    tokens=line.split('\t')
    chrom=tokens[0]
    start=int(tokens[1])
    end=int(tokens[2])
    name=tokens[3]
    if chrom not in gene_dict:
        gene_dict[chrom]=dict()
    gene_dict[chrom][start]=[end,name]
print("made gene dict!")
atac_peaks=open("chipseq_merged.averaged.txt",'r').read().strip().split('\n')
print('gene\t'+atac_peaks[0])
for line in atac_peaks[1::]:
    tokens=line.split('\t')
    chrom=tokens[0]
    start=int(tokens[1])
    end=tokens[2]
    vals=tokens[3::]
    if chrom not in gene_dict:
        continue
    candidates=gene_dict[chrom]
    for startpos in candidates:
        if abs(startpos-start)<10000 :
            cur_gene=candidates[startpos][1]
            outf.write(cur_gene+'_'+chrom+'_'+str(start)+'_'+end+'\t'+'\t'.join(vals)+'\n')
            break
        

