#checks enriched tf's for differential gene expression from RNA-seq data
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="check enriched tf's for differential gene expression from RNA-seq data")
    parser.add_argument("--motif_hits_h3k27me3")
    parser.add_argument("--earlyG1_df")
    parser.add_argument("--lateG1_df")
    parser.add_argumetn("--SG2M_df")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    earlyg1=open(args.earlyG1_df,'r').read().strip().split('\n')
    lateg1=open(args.lateG1_df,'r').read().strip().split('\n')
    sg2m=open(args.SG2M_df,'r').read().strip().split('\n')
    #create a dictionary of genes w/ differential expression values in given timepoints
    data_dict=dict()
    data_dict['earlyG1']=earlyg1
    data_dict['lateG1']=lateg1
    data_dict['sg2m']=sg2m
    
    diff_dict=dict()
    for timepoint in data_dict:
        for line in data_dict[timepoint]:
            tokens=line.split('\t')
            gene=tokens[0]
            fc=float(tokens[1])
            adj_pval=float(tokens[-1])
            #check for significance
            if ((abs(fc)>=1) and (adj_pval<=0.05)):
                if gene not in diff_dict:
                    diff_dict[gene]=dict()
                else:
                    diff_dict[gene][timepoint]=[fc,adj_pval] 
    print("generated differential dict")
    motif_hits=open(args.motif_hits_h3k27me3,'r').read().strip().split('\n')
    
    
    
if __name__=="__main__":
    main()
    
    
