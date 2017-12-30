inputs=open('all.combined.txt','r').read().strip().split('\n')
outf=open('all.combined.heatmap.txt','w')
all_dict=dict()
gene_set=set([])
path_set=set([]) 
for line in inputs:
    tokens=line.split('\t')
    gene=tokens[0]
    for time in ['earlyg1','lateg1','sg2m']:
        gene_set.add(gene+'.'+time)
    pathways=tokens[2]
    if pathways=="NA":
        continue
    pathways=pathways.split('|')
    for pathway in pathways:
        path_set.add(pathway)        
    label=tokens[1].split('.')
    time=label[0].lower() 
    direction=label[1]
    if direction=="up":
        direction=1
    elif direction=="down":
        direction=-1
    gene=gene+'.'+time
    if gene not in all_dict:
        all_dict[gene]=dict()
    for pathway in pathways:
        all_dict[gene][pathway]=direction 

gene_set=list(gene_set)
gene_set.sort()
path_set=list(path_set)
path_set.sort()
outf.write('Gene.Time'+'\t'+'\t'.join(path_set)+'\n')
for gene in gene_set:
    if gene not in all_dict:
        continue 
        #outf.write('\t0'*len(path_set)+'\n')
    else:
        outf.write(gene)
        for path in path_set:
            if path in all_dict[gene]:
                outf.write('\t'+str(all_dict[gene][path]))
            else:
                outf.write('\t0')
        outf.write('\n')
        
