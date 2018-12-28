#some genes have multiple different start codons -- we find the start codon with smallest distance to a differential peak
import pandas as pd
distinfo=pd.read_table("diff_promoter_to_diff_peak_dist.txt",header=0,sep='\t')
gene_to_dist=dict()
for index,row in distinfo.iterrows():
    gene_name=row[5]
    gene_dist=row[-1]
    if gene_name not in gene_to_dist:
        gene_to_dist[gene_name]=gene_dist
    elif gene_dist < gene_to_dist[gene_name]:
        gene_to_dist[gene_name]=gene_dist
print(len(gene_to_dist.keys()))
outf=open("distance_to_closest_peak_from_promoter.txt",'w')
for gene_name in gene_to_dist:
    outf.write(gene_name+'\t'+str(gene_to_dist[gene_name])+'\n')
    
