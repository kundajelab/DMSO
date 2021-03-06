#some genes have multiple different start codons -- we find the start codon with smallest distance to a differential peak
import pandas as pd
import sys
genenamecol=sys.argv[1]
inputf=sys.argv[2]
outputf=sys.argv[3]
distinfo=pd.read_table(inputf,header=0,sep='\t')
gene_to_dist=dict()
for index,row in distinfo.iterrows():
    gene_name=row[int(genenamecol)]
    gene_dist=row[-1]
    if gene_name not in gene_to_dist:
        gene_to_dist[gene_name]=gene_dist
    elif gene_dist < gene_to_dist[gene_name]:
        gene_to_dist[gene_name]=gene_dist
print(len(gene_to_dist.keys()))
outf=open(outputf,'w')
for gene_name in gene_to_dist:
    outf.write(gene_name+'\t'+str(gene_to_dist[gene_name])+'\n')
    
