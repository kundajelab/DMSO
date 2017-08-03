#helper script to merge outputs from the tad enrichment analysis steps
import argparse
import pdb
def parse_args():
    parser=argparse.ArgumentParser(description="helper script to merge outputs from the tad enrichment analysis steps")
    parser.add_argument("--to_merge",nargs="+")
    parser.add_argument("--labels",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    to_merge=args.to_merge
    dictionaries=[]
    print(str(dictionaries))
    labels=args.labels
    outf=open(args.outf,'w')
    outf.write('chrom\tstart\tstop\t'+'\t'.join(labels)+'\n')
    assert(len(to_merge)==len(labels))
    for i in range(len(to_merge)):
        data=open(to_merge[i],'r').read().strip().split('\n')
        print(str(to_merge[i]))
        cur_dict=dict() 
        for line in data:
            tokens=line.split('\t')
            key=tuple(tokens[0:3])
            val=tokens[-1]
            print(str(key))
            print(str(val))
            cur_dict[key]=val
        dictionaries.append(cur_dict)
    print("Generated dictionaries of values!")
    #print(str(dictionaries))
    #pdb.set_trace()
    
    #Now, merge into a single file
    merged=dict()
    for i in range(len(labels)):
        for key in dictionaries[i]:
            val=dictionaries[i][key]
            if key in merged:
                merged[key][i]=val
            else:
                merged[key]=['']*len(labels)
                merged[key][i]=val
    #write to a single joint file
    for key in merged:
        outf.write('\t'.join(key)+'\t'+'\t'.join(merged[key])+'\n')
        
if __name__=="__main__":
    main()
    
    
