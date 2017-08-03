#computes empirical p-value based on permutation test and observed values 
import argparse
import numpy as np

def parse_args():
    parser=argparse.ArgumentParser(description="extracts tads from a permutation result that have 2+ peak hits in the differential peak set")
    parser.add_argument("--permutation_result")
    parser.add_argument("--observed_result")
    parser.add_argument("--out_prefix")
    return parser.parse_args()

def main():
    args=parse_args()
    observed_dict=dict()
    observed_data=open(args.observed_result,'r').read().strip().split('\n')
    permutation_data=open(args.permutation_result,'r').read().strip().split('\n')

    for line in observed_data:
        tokens=line.split('\t')
        if len(tokens)<4:
            continue 
        tad=tuple(tokens[0:3])
        value=int(tokens[3])
        if value > 1:
            observed_dict[tad]=value 
    outf=open(args.out_prefix+'.empirical.pvalues','w')
    keep_dict=dict() 
    for line in permutation_data:
        tokens=line.split('\t')
        tad=tuple(tokens[0:3])
        if tad in observed_dict:
            # keep this peak!
            observed_value=observed_dict[tad] 
            vals=[float(i) for i in tokens[3::]]
            #compute a one-sided p-value to see if the tad is enriched.
            total=len(vals)
            random_hits=0
            for entry in vals:
                if entry>=observed_value:
                    random_hits+=1
            #how likely are we to see values >= to observed count in the tad?
            p_value=float(random_hits)/total 
            outf.write('\t'.join(peak)+'\t'+str(p_value)+'\n')
    
if __name__=="__main__":
    main() 
