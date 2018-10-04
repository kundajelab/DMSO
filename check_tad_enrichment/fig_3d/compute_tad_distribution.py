#used to generate figure 3d
ordered_tads=open("all.tads.bed",'r').read().strip().split('\n')
diff_genes_to_tads=open("tads.genes",'r').read().strip().split('\n')
diff_peaks_to_tads=open("tads.peaks",'r').read().strip().split('\n')
print("read in data files")

#get adjacent tads
adjacent_tads=dict()
for i in range(1,len(ordered_tads)-1):
    prev_tad=ordered_tads[i-1]
    next_tad=ordered_tads[i+1]
    cur_tad=ordered_tads[i]
    adjacent_tads[cur_tad]=[prev_tad,next_tad]
adjacent_tads[ordered_tads[0]]=[ordered_tads[1]]
adjacent_tads[ordered_tads[-1]]=[ordered_tads[-2]]

#get dictionary of gene to tad
gene_to_tad=dict()
tad_to_gene=dict() 
for line in diff_genes_to_tads:
    tokens=line.split('\t')
    gene=tokens[3]
    tad='\t'.join(tokens[4::])
    gene_to_tad[gene]=tad
    if tad not in tad_to_gene:
        tad_to_gene[tad]=[gene]
    else:
        tad_to_gene[tad].append(gene)

#get dictionary of peak to tad
peak_to_tad=dict()
tad_to_peak=dict()
for line in diff_peaks_to_tads:
    tokens=line.split('\t')
    peak='\t'.join(tokens[0:3])
    tad='\t'.join(tokens[3::])
    peak_to_tad[peak]=tad
    if tad not in tad_to_peak:
        tad_to_peak[tad]=[peak]
    else:
        tad_to_peak[tad].append(peak)
        
#get counts for peaks relative to genes
peaks_with_gene_same_tad=0
peaks_with_gene_adjacent_tad=0
peaks_other=0
genes_with_peak_same_tad=0
genes_with_peak_adjacent_tad=0
genes_other=0

#get counts for genes relative to peaks
for peak in peak_to_tad:
    cur_tad=peak_to_tad[peak]
    if cur_tad in tad_to_gene:
        peaks_with_gene_same_tad+=1
    else:
        try:
            nearby_tads=adjacent_tads[cur_tad]
            found=False
            for tad in nearby_tads:
                if tad in tad_to_gene:
                    peaks_with_gene_adjacent_tad+=1
                    found=True
                    break
            if found==False:
                peaks_other+=1
        except:
            continue
for gene in gene_to_tad:
    cur_tad=gene_to_tad[gene]
    if cur_tad in tad_to_peak:
        genes_with_peak_same_tad+=1
    else:
        try:
            nearby_tads=adjacent_tads[cur_tad]
            found=False
            for tad in nearby_tads:
                if tad in tad_to_peak:
                    genes_with_peak_adjacent_tad+=1
                    found=True
                    break
            if found==False:
                genes_other+=1
        except:
            continue
        
#write output file
outf=open('peak_to_gene.summary','w')
outf.write('peaks_with_gene_same_tad\t'+str(peaks_with_gene_same_tad)+'\n')
outf.write('peaks_with_gene_adjacent_tad\t'+str(peaks_with_gene_adjacent_tad)+'\n')
outf.write('peaks_other\t'+str(peaks_other)+'\n')
outf.write('genes_with_peak_same_tad\t'+str(genes_with_peak_same_tad)+'\n')
outf.write('genes_with_peak_adjacent_tad\t'+str(genes_with_peak_adjacent_tad)+'\n')
outf.write('genes_other\t'+str(genes_other)+'\n')
