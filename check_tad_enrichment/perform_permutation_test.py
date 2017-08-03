#NOTE: some code is duplicated from get_peak_distribution_in_tads.py;
#Best to remove this duplication in the future

import argparse
import random

def parse_args():
    parser=argparse.ArgumentParser(description="Perform a sampling test to check if any TAD's are enriched")
    parser.add_argument("--peaks")
    parser.add_argument("--num_to_sample",type=int)
    parser.add_argument("--tads")
    parser.add_argument("--outf")
    parser.add_argument("--binsize",type=int,default=5000)
    parser.add_argument("--num_samples",type=int,default=10000)
    return parser.parse_args()

def main():
    args=parse_args()
    tads=open(args.tads,'r').read().strip().split('\n')
    peaks=open(args.peaks,'r').read().strip().split('\n')
    binsize=args.binsize
    num_to_sample=args.num_to_sample
    num_samples=args.num_samples
    
    tad_dict=dict()
    tad_distribution=dict()
    for tad in tads:
        tokens=tad.split('\t')
        chrom=tokens[0]
        startval=int(tokens[1])
        endval=int(tokens[2])
        if chrom not in tad_dict:
            tad_dict[chrom]=dict()
            tad_distribution[chrom]=dict() 
        tad_dict[chrom][startval]=endval
        tad_distribution[chrom][startval]=[0]*num_samples  
    print("generated tad dictionary")

    cur_sample=0
    num_peaks=len(peaks)
    print(str(num_peaks))
    print(str(num_to_sample))
    while cur_sample < num_samples:
        #sample randomly from the peak set
        subset_indices=random.sample(range(num_peaks),num_to_sample)
        peak_subset=[peaks[i] for i in subset_indices]
        for peak in peak_subset:
            tokens=peak.split('\t')
            chrom=tokens[0]
            if chrom not in tad_dict:
                continue
            startval=int(tokens[1])
            endval=int(tokens[2])
            if chrom in tad_dict:
                for tad_start in tad_dict[chrom]:
                    if tad_start <= startval:
                        tad_end=tad_dict[chrom][tad_start]
                        if tad_end >= endval:
                            #we have a hit!
                            tad_distribution[chrom][tad_start][cur_sample]+=1
        cur_sample+=1
        print(str(cur_sample))

    outf=open(args.outf,'w')
    outf_mean=open(args.outf+'.mean','w')
    for chrom in tad_distribution:
        for startval in tad_distribution[chrom]:
            outf.write(chrom+'\t'+str(startval)+'\t'+str(tad_dict[chrom][startval])+'\t'+'\t'.join([str(i) for i in tad_distribution[chrom][startval]])+'\n')
            #get the mean value for each tad
            outf_mean.write(chrom+'\t'+str(startval)+'\t'+str(tad_dict[chrom][startval])+'\t'+str(sum(tad_distribution[chrom][startval])*1.0/num_samples)+'\n')
            
if __name__=="__main__":
    main()
