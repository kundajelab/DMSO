cluster_map=dict()
cluster_map[1]="earlyG1.up"
cluster_map[2]="SG2M.down"
cluster_map[3]="lateG1.up"
cluster_map[4]="lateG1.down"
cluster_map[5]="earlyG1.down"
cluster_map[6]="SG2M.up"
print(str(cluster_map))
optim=open("_optimal_clustering.txt",'r').read().strip().split('\n')
#generate assignment of peak to cluster 
peak_to_cluster=dict()
for line in optim[1::]:
    tokens=line.split('\t')
    cluster=int(tokens[0])
    peak=tokens[1]
    peak_to_cluster[peak]=cluster_map[cluster]
print(str(peak_to_cluster))
#generate assignment of ref gene to TSS
tss_dict=dict()
tss=open("refGene_hg19_TSS.bed",'r').read().strip().split('\n')
for line in tss:
    tokens=line.split('\t')
    gene=tokens[-2]
    pos=tuple(tokens[0:3])
    tss_dict[gene]=pos
    
#iterate through the 4 pathways of interest
pathways=['pi3k_akt','tnf','wnt','vegf','pkc_mapk','circadian','gpcr','cilium_assembly','apoptosis','interleukins']
for p in pathways:
    data=open(p,'r').read().strip().split('\n')
    outf=open(p+'.filtered','w')
    for line in data:
        tokens=line.split('\t')
        if len(tokens)<4:
            continue 
        gene=tokens[0]
        cluster=tokens[1]
        peak=tokens[3]
        try:
            peak_cluster=peak_to_cluster[peak]
        except:
            continue
            
        if (peak_cluster !=cluster):
            continue
        #if we are here, the gene has an associated ATAC-seq peak in the same cluster
        try:
            motif =tokens[6]
        except:
            continue
        chrom_state=tokens[-1]
        tss_cur_gene=tss_dict[gene]
        #make sure peak & gene are on same chrom!
        peak_parts=peak.split('_')
        peak_chrom=peak_parts[0]
        gene_chrom=tss_cur_gene[0]
        if (peak_chrom!=gene_chrom):
            continue
        #they are on same chrom
        distance = int(peak_parts[1])-int(tss_cur_gene[1])
        outf.write(gene+'\t'+peak+'\t'+motif+'\t'+str(distance)+'\t'+cluster+'\t'+chrom_state+'\n')
        
        
