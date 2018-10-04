#generate data tracks for plotting with Circos 
import argparse
import math
import random

def parse_args():
    parser=argparse.ArgumentParser(description="generate data tracks for plotting with circos")
    parser.add_argument("--pathway_to_gene")
    parser.add_argument("--gene_to_peak")
    parser.add_argument("--chrom_hmm_state_map")
    parser.add_argument("--chrom_hmm_annotation")
    parser.add_argument("--gene_coords") 
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    
    #Read the inputs 
    args=parse_args()
    path_to_gene=open(args.pathway_to_gene,'r').read().strip().split('\n')
    gene_to_peak=open(args.gene_to_peak,'r').read().strip().split('\n')
    chrom_hmm_state_map=open(args.chrom_hmm_state_map,'r').read().strip().split('\n')
    chrom_hmm_annotation=open(args.chrom_hmm_annotation,'r').read().strip().split('\n')
    gene_coords=open(args.gene_coords,'r').read().strip().split('\n')
    gene_coord_dict=dict()
    for line in gene_coords:
        tokens=line.split('\t')
        gene=tokens[-1]
        chrom=tokens[0].replace('chr','hs') 
        startpos=tokens[1]
        endpos=tokens[2]
        gene_coord_dict[gene]=[chrom,startpos,endpos] 
    
    #Generate the output files
    outf_genes=open(args.outf+'.gene.tiles.conf','w')
    outf_gene_labels=open(args.outf+'.gene.labels.conf','w')
    outf_peaks=open(args.outf+'.peak.tiles.conf','w')
    outf_peak_labels=open(args.outf+'.peak.labels.conf','w')    
    
    #0) Peak track         
    hmm_state_dict=dict() 
    for line in chrom_hmm_state_map:
        tokens=line.split('\t')
        hmm_state_dict[tokens[0]]=tokens[-1]

    chrom_hmm_dict=dict()
    for line in chrom_hmm_annotation:
        tokens=line.split('\t')
        peak='_'.join(tokens[0:3])
        state=hmm_state_dict[tokens[-1]]
        chrom_hmm_dict[peak]=state

    gene_dict=dict()
    peak_dict=dict()
    
    for line in gene_to_peak[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        peak=tokens[1]
        color=chrom_hmm_dict[peak]
        peak=peak.split('_')
        peak[0]=peak[0].replace('chr','hs')
        if tuple(peak) not in peak_dict:
            peak_dict[tuple(peak)]=1
            outf_peaks.write('\t'.join(peak)+'\t'+'color='+color+'\t'+'stroke_color='+color+'\n')
        if len(tokens)>4:
            motif=tokens[4]
            outf_peak_labels.write('\t'.join(peak)+'\t'+motif+'\n')
            
        #1) gene track
        if gene not in gene_dict:
            gene_dict[gene]=1
            coords=gene_coord_dict[gene] 
            outf_genes.write(coords[0]+'\t'+coords[1]+'\t'+coords[2]+'\n')
            outf_gene_labels.write(coords[0]+'\t'+coords[1]+'\t'+coords[2]+'\t'+gene+'\n')
            
    curpath_index=0
    outf_pathways=open(args.outf+".pathways",'w')
    for line in path_to_gene[1::]:
        curpath_index+=1 
        tokens=line.split('\t')
        pathway=tokens[0].replace(' ','_') 
        fdr=tokens[5]
        outf_pathways.write(str(curpath_index)+'\t'+pathway+'\t'+fdr+'\n')
        color_r=random.randint(0,256)
        color_g=random.randint(0,256)
        color_b=random.randint(0,256)
        color=str(color_r)+','+str(color_g)+','+str(color_b) 
        genes=tokens[6].split(',')
        #if the genes have not been recorded yet, record them!
        outf_links=open(args.outf+'.pathway.p'+str(curpath_index)+'.conf','w')
        for gene in genes:
            coords=gene_coord_dict[gene]
            if gene not in gene_dict:
                gene_dict[gene]=1
                outf_genes.write(coords[0]+'\t'+coords[1]+'\t'+coords[2]+'\n')
                outf_gene_labels.write(coords[0]+'\t'+coords[1]+'\t'+coords[2]+'\t'+gene+'\n')
            outf_links.write('\t'.join(coords)+'\t'+gene+'\t'+'color='+'black'+'\n')
            

if __name__=="__main__":
    main()
    
    
    
