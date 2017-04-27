#combine fc values for individual pseudo-replicates into a single tsv file of position x replicate
import argparse

def parse_args():
    parser=argparse.ArgumentParser("provide list of files that contain the peaks in indivdiual pseudo-replicates and an  output file to store the merged .tsv")
    parser.add_argument("--merged_peaks",help="bed file of merged peak positions") 
    parser.add_argument("--file_list",help="text file containing list of files to merge" )
    parser.add_argument("--o",help="name of output file" )
    return parser.parse_args()

def main():
    args=parse_args()
    individual_files=open(args.file_list,'r').read().strip().split('\n')
    merged_peak_set=open(args.merged_peaks,'r').read().strip().split('\n')
    peaks=dict()
    outf=open(args.o,'w')
    for fname in individual_files: 
        data=open(fname,'r').read().strip().split('\n') 
        peaks[fname]=dict() 
        for line in data: 
            tokens=line.split('\t') 
            pos='\t'.join(tokens[1:4])
            val=tokens[0]
            peaks[fname][pos]=val 
    print('made peak dictionaries') 
    samples=peaks.keys() 
    outf.write('Chrom\tStart\tEnd\t'+'\t'.join(samples)+'\n')
    for line in merged_peak_set: 
        outf.write(line) 
        for sample in samples: 
            if line in peaks[sample]: 
                outf.write('\t'+peaks[sample][line])
            else: 
                outf.write('\t1')
        outf.write('\n') 


if __name__=="__main__":
    main() 
