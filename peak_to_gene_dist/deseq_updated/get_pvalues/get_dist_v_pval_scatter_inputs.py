import pdb
#generates a mapping of distance to pvalue for scatterplot
gene_dist=open("genes.closest.filtered.bed",'r').read().strip().split('\n')
gene_dist_dict=dict()
for line in gene_dist:
    tokens=line.split('\t')
    gene=tokens[0]
    dist=tokens[1]
    gene_dist_dict[gene]=dist
pdb.set_trace()     
gene_pval=open("gene.pval").read().strip().split('\n')
outf_gene=open("gene.dist.to.pval.tsv",'w')
outf_gene.write("GeneName\tGenePval\tGeneDist\n")
for line in gene_pval:
    tokens=line.split('\t')
    name=tokens[0]
    pval=tokens[-1]
    try:
        dist=gene_dist_dict[name]
        outf_gene.write(name+'\t'+pval+'\t'+dist+'\n')
    except:
        print(name)
        
peak_dist=open("peaks.closest.bed",'r').read().strip().split('\n')
peak_dist_dict=dict()
for line in peak_dist:
    tokens=line.split('\t')
    peak_name='_'.join(tokens[0:3])
    peak_dist=tokens[-1]
    peak_dist_dict[peak_name]=peak_dist

peak_pval=open("peak.pval").read().strip().split('\n')
outf_peak=open("peak.dist.to.pval.tsv",'w') 
outf_peak.write("PeakName\tPeakPval\tPeakDist\n")
for line in peak_pval:
    tokens=line.split('\t')
    name='_'.join(tokens[0:3])
    pval=tokens[-1]
    dist=peak_dist_dict[name]
    outf_peak.write(name+'\t'+pval+'\t'+dist+'\n')
