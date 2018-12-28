#collapses bedtools intersect results of chromHMM annotation file and peak file 
import argparse
import pdb
def parse_args():
    parser=argparse.ArgumentParser(description="annotates peak file with chromHMM state")
    parser.add_argument("--intersection_file") 
    parser.add_argument("--outf")
    return parser.parse_args()


        
def main():
    args=parse_args()
    data=open(args.intersection_file).read().strip().split('\n')
    outf=open(args.outf,'w')
    data_dict=dict()
    for line in data:
        tokens=line.split('\t')
        peak=tuple(tokens[0:3])
        overlap=int(tokens[-1])
        category=tokens[-2]
        if peak not in data_dict:
            data_dict[peak]=[overlap,category]
        else:
            cur_overlap=data_dict[peak][0]
            if overlap>cur_overlap:
                data_dict[peak]=[overlap,category]
    for peak in data_dict:
        outf.write('\t'.join(list(peak))+'\t'+str(data_dict[peak][1])+'\n')
        
if __name__=="__main__":
    main() 
    
