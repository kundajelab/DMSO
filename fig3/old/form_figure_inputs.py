#aggregate all components to generate figure 3
gene_tpm=open("all_differential_genes.dpgp.input.tsv",'r').read().strip().split('\n')
gene_tpm_dict=dict()
for line in gene_tpm[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    gene_tpm_dict[gene]=tokens[1::]
    
peak_cpm=open("all_differential_peaks.dpgp.input.tsv",'r').read().strip().split('\n')
peak_cpm_dict=dict() 
for line in peak_cpm[1::]:
    tokens=line.split('\t')
    peak='_'.join(tokens[0].split('_')[0:2])
    peak_cpm_dict[peak]=tokens[1::]
    
peak_gene_rel=open('all.combined.txt','r').read().strip().split('\n')
peak_gene_map=dict()
for line in peak_gene_rel[1::]:
    tokens=line.split('\t')
    if (len(tokens)<4):
        continue 
    gene=tokens[0]
    path=tokens[2] 
    peak=tokens[3]
    motif=tokens[-2]
    state=tokens[-1]
    entry=[peak,path,motif,state]
    if gene not in peak_gene_map:
        peak_gene_map[gene]=[entry]
    else:
        peak_gene_map[gene].append(entry)
        
for time in ['earlyG1','lateG1','SG2M']:
    for direction in ['up','down']: 
        gene_pos=open(time+'.'+direction+".circos.txt",'r').read().strip().split('\n')
        outf=open(time+'.'+direction+'.toplot.tsv','w')
        for line in gene_pos:
            tokens=line.split('\t')
            gene=tokens[3]
            pos=int(tokens[1])
            exp=gene_tpm_dict[gene]
            if gene in peak_gene_map:
                for entry in peak_gene_map[gene]:
                    peak=entry[0]
                    peak_pos=int(peak.split('_')[1])
                    dist=str(pos-peak_pos)
                    path=entry[1]
                    motif=entry[2]
                    state=entry[3]
                    try:
                        access=peak_cpm_dict['_'.join(peak.split('_')[0:2])] 
                        outf.write(gene+'\t'+'\t'.join(exp)+'\t'+peak+'\t'+'\t'.join(access)+'\t'+motif+'\t'+dist+'\t'+state+'\n')
                    except:
                        print(str(peak))
            else:
                outf.write(gene+'\t'+'\t'.join(exp)+'\n')
                
