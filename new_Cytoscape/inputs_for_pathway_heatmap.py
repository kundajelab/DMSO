import argparse
import pandas as pd
from  math import log10

def parse_args():
    parser=argparse.ArgumentParser(description="generate pathway heatmap")
    parser.add_argument("--inputs",nargs="+")
    parser.add_argument("--outf")
    parser.add_argument("--term_key",default="GeneSet")
    return parser.parse_args()

def main():
    args=parse_args()
    term_dict=dict()
    for sample in args.inputs:
        data=pd.read_csv(sample,header=0,sep='\t')
        for index,row in data.iterrows():
            geneset=row[args.term_key]
            fdr=-10*log10(row['FDR'])
            if geneset not in term_dict:
                term_dict[geneset]=dict()
            term_dict[geneset][sample]=fdr
        print("parsed:"+str(sample))
    outf=open(args.outf,'w')
    samples=args.inputs
    outf.write(args.term_key+'\t'+'\t'.join(samples)+'\n')
    for geneset in term_dict:
        outf.write(geneset)
        for sample in samples:
            if sample in term_dict[geneset]:
                outf.write('\t'+str(term_dict[geneset][sample]))
            else:
                outf.write('\t0') 
        outf.write('\n')

    
if __name__=="__main__":
    main() 
