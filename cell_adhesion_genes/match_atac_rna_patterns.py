import argparse
import numpy as np 
import pdb

def parse_args():
    parser=argparse.ArgumentParser(description="filter down atac seq peaks to the ones that match or precede the corresponding gene expression pattern")
    parser.add_argument("--rna_zscores")
    parser.add_argument("--atac_zscores")
    parser.add_argument("--outf")
    return parser.parse_args() 
    
def main():
    args=parse_args()
    rna_data=open(args.rna_zscores,'r').read().strip().split('\n')
    atac_data=open(args.atac_zscores,'r').read().strip().split('\n')
    atac_header=atac_data[0]
    outf=open(args.outf,'w')
    outf.write(atac_header+'\n')
    #make dictionary for gene expression
    rna_dict=dict()
    for line in rna_data[1::]:
        tokens=line.split('\t')
        gene=tokens[0] 
        rna_dict[gene]=[float(i) for i in tokens[1::]] 
    print("make rna dict")
    for line in atac_data[1::]:
        tokens=line.split('\t')
        gene=tokens[0].split('_')[0]
        peak_vals=[float(i) for i in tokens[1::]]
        gene_vals=rna_dict[gene]
        max_magnitude_rna=max(np.abs(gene_vals))
        max_magnitude_atac=max(np.abs(peak_vals))
        rna_max_index=np.where(np.abs(gene_vals)==max_magnitude_rna)[0][0]
        atac_max_index=np.where(np.abs(peak_vals)==max_magnitude_atac)[0][0]
        if (atac_max_index==rna_max_index) or (atac_max_index==(rna_max_index-1)):
            #make sure the direction matches!
            atac_picked_val=peak_vals[atac_max_index]
            rna_picked_val=gene_vals[rna_max_index]
            if np.sign(atac_picked_val)==np.sign(rna_picked_val):
                #! we have a match
                outf.write(line+'\n')
                
    
if __name__=="__main__":
    main() 
