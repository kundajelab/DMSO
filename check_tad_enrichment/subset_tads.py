#extract the tads from a permutation result that have 2+ peak hits in the differential peak set
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
        peak=tuple(tokens[0:3])
        value=int(tokens[3])
        if value > 1:
            observed_dict[peak]=value 
    outf=open(args.out_prefix+'.zscores','w')
    outf_df=open(args.out_prefix+".df",'w')
    keep_dict=dict() 
    for line in permutation_data:
        tokens=line.split('\t')
        peak=tuple(tokens[0:3])
        if peak in observed_dict:
            # keep this peak!
            vals=[float(i) for i in tokens[3::]]
            num_to_keep=len(vals)
            mean=np.mean(vals)
            std=np.std(vals)
            z=(observed_dict[peak]-mean)/std
            outf.write('\t'.join(peak)+'\t'+str(z)+'\n')
            keep_dict['_'.join(peak)]=[str(i) for i in vals] 
    keys=list(keep_dict.keys())
    outf_df.write('\t'.join(keys)+'\n')
    for i in range(num_to_keep):
        outf_df.write(keep_dict[keys[0]][i])
        for j in range(1,len(keys)): 
            outf_df.write('\t'+keep_dict[keys[j]][i])
        outf_df.write('\n') 
    
if __name__=="__main__":
    main() 
