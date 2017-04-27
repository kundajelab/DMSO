import os
allfiles=os.listdir('/srv/scratch/annashch/dmso/gene_ranks_multifactor')
outf=open('heatmap_inputs.stringent.txt','w')
gene_dict=dict()
samples=set([])
for f in allfiles:
    if f=="HD_vs_LD.FILTERED":
        continue 
    if f.endswith('.FILTERED'):
        samples.add(f)
        data=open(f,'r').read().strip().split('\n')
        for line in data[1::]:
            tokens=line.split('\t') 
            gene_names=tokens[3].split(',')
            closest_gene=None
            closest_dist=float("inf") 
            fc=float(tokens[-1])
            for gene in gene_names:
                gene=gene.split('(')
                gene_name=gene[0].strip()
                try:
                    gene_dist=float(gene[1].split(')')[0])
                except:
                    continue 
                if gene_dist  < closest_dist:
                    closest_gene=gene_name
            if closest_gene==None:
                continue 
            if closest_gene not in gene_dict:
                gene_dict[closest_gene]=dict()
            if f not in gene_dict[closest_gene]:
                gene_dict[closest_gene][f]=fc
            else:
                if abs(fc)>abs(gene_dict[closest_gene][f]):
                    gene_dict[closest_gene][f]=fc
samples=list(samples)
outf.write('Gene\t'+'\t'.join(samples)+'\n')
for gene in gene_dict:
    outf.write(gene)
    for sample in samples:
        if sample in gene_dict[gene]:
            outf.write('\t'+str(round(gene_dict[gene][sample],3)))
        else:
            outf.write('\t0')
    outf.write('\n')
    
