data=open('gene_hits.tsv','r').read().strip().split('\n') 
outf_up=open('upregulated_with_DMSO.tsv','w') 
outf_down=open('downregulated_with_DMSO.tsv','w') 
outf_first_half=open('first_half.tsv','w') 
outf_second_half=open('second_half.tsv','w') 
for line in data: 
    tokens=line.split('\t') 
    status=tokens[6] 
    if status!="0": 
        outf_up.write(line+'\n')
    status=tokens[7] 
    if status!="0": 
        outf_down.write(line+'\n') 
    chrom=tokens[0].strip('chr') 
    if chrom in ['X','Y','M']: 
        outf_second_half.write(line+'\n') 
    elif int(chrom)<13: 
        outf_first_half.write(line+'\n') 
    elif int(chrom)>=13: 
        outf_second_half.write(line+'\n') 
        
