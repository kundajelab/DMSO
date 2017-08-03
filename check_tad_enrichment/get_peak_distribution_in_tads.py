#calculates the number of peaks from the provided peak set that are in each tad
import argparse
import pdb

def parse_args():
    parser=argparse.ArgumentParser(description="calculates the number of peaks from the provided peakset that are in each tad")
    parser.add_argument("--tads")
    parser.add_argument("--peaks")
    parser.add_argument("--outf")
    parser.add_argument("--binsize",type=int,default=40000)
    return parser.parse_args()

def main():
    args=parse_args()
    tads=open(args.tads,'r').read().strip().split('\n')
    peaks=open(args.peaks,'r').read().strip().split('\n')
    binsize=args.binsize
    
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
        tad_distribution[chrom][startval]=0 
    print("generated tad dictionary")

    counter=0
    for peak in peaks:
        counter+=1
        if counter % 1000==0:
            print(str(counter))
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
                        tad_distribution[chrom][tad_start]+=1
    print("assigned peaks to tad regions")


    outf=open(args.outf,'w')
    num_empty=0
    for chrom in tad_distribution:
        for startval in tad_distribution[chrom]:
            if tad_distribution[chrom][startval]==0:
                num_empty+=1
            else:
                outf.write(chrom+'\t'+str(startval)+'\t'+str(tad_dict[chrom][startval])+'\t'+str(tad_distribution[chrom][startval])+'\n')
    outf.write("NumberEmpty\t"+str(num_empty)+'\n')
    
if __name__=="__main__":
    main() 
