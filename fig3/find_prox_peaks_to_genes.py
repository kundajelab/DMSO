peaks=open("../all_peaks.idr.sorted.merged",'r').read().strip().split('\n')
peak_dict=dict()
binsize=10000
for line in peaks:
    tokens=line.split('\t')
    tokens[1]=int(tokens[1])
    tokens[2]=int(tokens[2])
    entry=tuple(tokens)
    chrom=tokens[0]
    if chrom not in peak_dict:
        peak_dict[chrom]=dict()
    cur_bin=tokens[1]/binsize
    first_bin=max([0,cur_bin])
    last_bin=cur_bin+1
    for b in range(first_bin,last_bin+1):
        if b not in peak_dict[chrom]:
            peak_dict[chrom][b]=[entry]
        else:
            peak_dict[chrom][b].append(entry)
print("generated hash of chromatin peaks")
pathway_files=['pi3k_akt.coord.txt','tnf_alpha.coord.txt','wnt.coord.txt','vegf.coord.txt']
for pathway_file in pathway_files:
    gene_tss=open(pathway_file,'r').read().strip().split('\n')
    outf=open(pathway_file+".prox_peaks",'w') 
    for line in gene_tss:
        tokens=line.split()
        gene=tokens[-2]
        chrom=tokens[0]
        tss=int(tokens[1])
        cur_bin=tss/binsize
        first_bin=max([0,cur_bin])
        last_bin=cur_bin+1 
        candidate_peaks=[]
        if chrom in peak_dict:
            for b in range(first_bin,last_bin+1): 
                if b in peak_dict[chrom]:
                    candidate_peaks=candidate_peaks+peak_dict[chrom][b]
            for peak in candidate_peaks:
                distance=abs(peak[1]-tss)
                if distance < binsize:
                    #this is a proximal peak!
                    outf.write(gene+'\t'+'\t'.join([str(i) for i in peak])+'\n')
            

