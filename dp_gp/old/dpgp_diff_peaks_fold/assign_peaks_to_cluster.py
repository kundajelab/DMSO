#get the bed files for peak sets in each cluster
optim_clustering=open("_optimal_clustering.txt",'r').read().strip().split('\n')
cluster_dict=dict()
for line in optim_clustering[1::]:
    tokens=line.split('\t')
    cluster=tokens[0]
    peak=tokens[1].replace('_','\t')
    if cluster not in cluster_dict:
        cluster_dict[cluster]=[peak]
    else:
        cluster_dict[cluster].append(peak)
print("generated dictionary of clusters")
outfiles=[open(str(i)+'.bed','w') for i in range(1,7)]
for i in range(1,7):
    outfiles[i-1].write('\n'.join(cluster_dict[str(i)])+'\n')
    
    
