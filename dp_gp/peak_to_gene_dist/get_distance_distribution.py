#compare distribution of peak-gene distances in same cluster vs. peak-gene distances to other clusters.
from pybedtools import BedTool
def get_background(to_exclude):
    peak_background=""
    gene_background=""    
    for i in range(1,7):
        if (i!=to_exclude):
            cur_peaks=open(str(i)+".peaks.bed").read()
            cur_genes=open(str(i)+".genes.bed").read()
            peak_background=peak_background+'\n'+cur_peaks
            gene_background=gene_background+'\n'+cur_genes
    peak_background=BedTool(peak_background,from_string=True)
    gene_background=BedTool(gene_background,from_string=True)
    peak_background=peak_background.sort()
    gene_background=gene_background.sort()
    return peak_background,gene_background 
import pdb 
for cluster in range(1,7):
    #get the peaks & genes for the current cluster 
    peak_bed=BedTool(str(cluster)+".peaks.bed")
    gene_bed=BedTool(str(cluster)+".genes.bed")
    #get the background
    peak_background,gene_background=get_background(cluster)
    #peak to gene closest, cur cluster
    peak_to_gene_foreground=[int(str(i).strip().split('\t')[-1]) for i in peak_bed.closest(gene_bed,wao=True,d=True)]
    #gene to peak closest, cur cluster
    gene_to_peak_foreground=[int(str(i).strip().split('\t')[-1]) for i in gene_bed.closest(peak_bed,wao=True,d=True)]
    #peak to gene closest, background
    peak_to_gene_background=[int(str(i).strip().split('\t')[-1]) for i in peak_bed.closest(gene_background,wao=True,d=True)]
    #gene to peak closest, background
    gene_to_peak_background=[int(str(i).strip().split('\t')[-1]) for i in gene_bed.closest(peak_background,wao=True,d=True)]
    print("got closest values for cluster "+str(cluster))
    #append the peak and gene distances to consider them in a single distribution
    foreground=peak_to_gene_foreground+gene_to_peak_foreground
    background=peak_to_gene_background+gene_to_peak_background
    print(str(len(foreground)))
    print(str(len(background)))
    outf=open(str(cluster)+'.dist','w')
    outf.write('\n'.join([str(i)+'\tforeground' for i in foreground]))
    outf.write('\n') 
    outf.write('\n'.join([str(i)+'\tbackground' for i in background]))
    
    
    

