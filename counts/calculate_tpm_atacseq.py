#script to calculate tpm from read counts & peak positions
#TPM is very similar to RPKM and FPKM. The only difference is the order of operations. Here's how you calculate TPM:
#Divide the read counts by the length of each gene in kilobases. This gives you reads per kilobase (RPK).
#Count up all the RPK values in a sample and divide this number by 1,000,000. This is your 'per million' scaling factor.
#Divide the RPK values by the 'per million' scaling factor. This gives you TPM.
            
import argparse
import numpy as np
import pdb

def parse_args():
    parser=argparse.ArgumentParser(description="Script to calculate TPM from read counts & peak positions")
    parser.add_argument("--counts")
    parser.add_argument("--peaks")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    counts=np.loadtxt(args.counts)
    print("loaded counts") 
    dtype_dict=dict()
    dtype_dict['names']=('chrom',
                         'start_pos',
                         'end_pos')
    dtype_dict['formats']=('S36',
                           'i',
                           'i')
    peaks=np.genfromtxt(args.peaks,
                        dtype=dtype_dict['formats'],
                        names=dtype_dict['names'],
                        delimiter='\t',
                        skip_header=False,
                        loose=True,
                        invalid_raise=True)
    print("loaded peaks")
    lengths=1.0*(peaks['end_pos']-peaks['start_pos']+1)
    rpk=counts/lengths[:,None]
    scaled=np.sum(rpk,axis=0)/1000000.0
    tpm=rpk/scaled[None,:]
    np.savetxt(args.outf,
               tpm,
               fmt='%4f',
               delimiter='\t')
                        
if __name__=="__main__":
    main()
    
