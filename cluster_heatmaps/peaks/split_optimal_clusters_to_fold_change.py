clusters=open("dpgp_diff_peaks_fold_optimal_clustering.txt",'r').read().strip().split('\n')
tpm=open("fold_change_atac.dpgp.input.diffpeaks.tsv",'r').read().strip().split('\n')
tpm_dict=dict()
for line in tpm[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    vals=tokens[1::]
    tpm_dict[gene]=vals
print("made values dictionary")
cluster_indices=list(set([i.split()[0] for i in clusters]))
outputs=dict() 
for i in cluster_indices:
    outputs[i]=open(i+'.fold_change_cpm','w')
    outputs[i].write("Peak\tearlyG1\tlateG1\tSG2M\n")
print("opened files")
for line in clusters[1::]:
    tokens=line.split()
    cluster=tokens[0]
    gene=tokens[1]
    cur_vals=tpm_dict[gene]
    outputs[cluster].write(gene+'\t'+'\t'.join(cur_vals)+'\n')
