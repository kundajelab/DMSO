#we need to have a coherent story between the ATAC-seq differential events and the RNA-seq differential events. Have you checked how often a differential peak is in the same TAD or next door TAD as a differential gene
binsize=50000
tads=open("all.tads.bed",'r').read().strip().split('\n')
pos_to_tad=dict()
tad_to_neighbors=dict()

neighbor_before=None
for line in tads:
    tokens=line.split('\t')
    chrom=tokens[0]
    if chrom not in pos_to_tad:
        pos_to_tad[chrom]=dict()
    startpos=int(tokens[1])
    endpos=int(tokens[2])
    binval=binsize*(startpos/binsize)
    if binval not in pos_to_tad[chrom]:
        pos_to_tad[chrom][binval]=[]
    curtad=tuple([chrom,startpos,endpos])
    pos_to_tad[chrom][binval].append(curtad)
    tad_to_neighbors[curtad]=[neighbor_before]
    if neighbor_before!=None:
        tad_to_neighbors[neighbor_before].append(curtad)
    neighbor_before=curtad
print("indexed tads")

diff_peaks=open("differential_atac_peaks.bed",'r').read().strip().split('\n')
tad_to_diff_peak=dict()
for line in diff_peaks:
    tokens=line.split('\t')
    chrom=tokens[0]
    startpos=int(tokens[1])
    endpos=int(tokens[2])
    binval=binsize*(startpos/binsize)
    try:
        options=pos_to_tad[chrom][binval]
    except:
        options=[item for sublist in pos_to_tad[chrom].values() for item in sublist ]
    for option in options:
        possible_start=option[1]
        possible_end=option[2]
        if startpos >= possible_start:
            if endpos <= possible_end:
                #we found the tad!
                curtad=tuple([chrom,possible_start,possible_end])
                if option not in tad_to_diff_peak:
                    tad_to_diff_peak[curtad]=[tuple([chrom,startpos,endpos])]
                else:
                    tad_to_diff_peak[curtad].append(tuple([chrom,startpos,endpos]))
print("indexed differential peaks")

diff_genes=open("differential_genes.bed").read().strip().split('\n')
tad_to_diff_gene=dict()
for line in diff_genes:
    tokens=line.split('\t')
    chrom=tokens[0]
    startpos=int(tokens[1])
    endpos=int(tokens[2])
    name=tokens[3]
    binval=binsize*(startpos/binsize)
    try:
        options=pos_to_tad[chrom][binval]
    except:
        try:
            options=[item for sublist in pos_to_tad[chrom].values() for item in sublist ]
        except:
            continue
    for option in options:
        possible_start=option[1]
        possible_end=option[2]
        if startpos >= possible_start:
            if endpos <= possible_end:
                #we found the tad!
                curtad=tuple([chrom,possible_start,possible_end])
                if option not in tad_to_diff_gene:
                    tad_to_diff_gene[curtad]=[tuple([chrom,startpos,endpos,name])]
                else:
                    tad_to_diff_gene[curtad].append(tuple([chrom,startpos,endpos,name]))
print("indexed differential peaks")


#Do the intersection
peaks_with_gene_in_same_tad=[]
peaks_with_gene_in_neighbor_tad=[]
peaks_with_no_near_diff_gene=[]

genes_with_peak_in_same_tad=[]
genes_with_peak_in_neighbor_tad=[]
genes_with_no_near_diff_peak=[] 

for tad in tad_to_diff_peak:
    if tad in tad_to_diff_gene:
        peaks_with_gene_in_same_tad.append(tad)
    else:
        neighbors=tad_to_neighbors[tad]
        for n in neighbors:
            if n in tad_to_diff_gene:
                peaks_with_gene_in_neighbor_tad.append(tad)
                break
        peaks_with_no_near_diff_gene.append(tad)

for tad in tad_to_diff_gene:
    if tad in tad_to_diff_peak:
        genes_with_peak_in_same_tad.append(tad)
    else:
        neighbors=tad_to_neighbors[tad]
        for n in neighbors:
            if n in tad_to_diff_peak:
                genes_with_peak_in_neighbor_tad.append(tad)
                break
        genes_with_no_near_diff_peak.append(tad)
print("diff_peak_with_diff_gene_in_same_tad\t"+str(len(peaks_with_gene_in_same_tad)))
print("diff_peak_with_diff_gene_in_neighbor_tad\t"+str(len(peaks_with_gene_in_neighbor_tad)))
print("diff_peak_with_no_near_diff_gene\t"+str(len(peaks_with_no_near_diff_gene)))
print("diff_gene_with_diff_peak_in_same_tad\t"+str(len(genes_with_peak_in_same_tad)))
print("diff_gene_with_diff_peak_in_neighbor_tad\t"+str(len(genes_with_peak_in_neighbor_tad)))
print("diff_gene_with_no_near_diff_peak\t"+str(len(genes_with_no_near_diff_peak)))


