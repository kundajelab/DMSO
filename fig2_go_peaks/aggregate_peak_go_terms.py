import argparse
import math 
def parse_args():
    parser=argparse.ArgumentParser(description="DAVID hits for gene sets")
    parser.add_argument("--hits",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    thresh=0.05
    outf=open(args.outf,'w')
    outf.write("Pathway"+"\t".join(args.hits)+'\n')
    pathway_dict=dict()
    term_set=set([])
    for sample in args.hits:
        data=open(sample,'r').read().strip().split('\n')
        for line in data[1::]:
            tokens=line.split('\t')
            term=tokens[1]
            pval=float(tokens[4])
            if pval >thresh:
                continue 
            term_set.add(term) 
            if term not in pathway_dict:
                pathway_dict[term]=dict()
            pathway_dict[term][sample]=-10*math.log10(float(pval))
    outf.write("Term"+"\t"+"\t".join(args.hits)+'\n')
    for term in term_set:
        outf.write(term)
        for sample in args.hits:
            if sample in pathway_dict[term]:
                outf.write('\t'+str(pathway_dict[term][sample]))
            else:
                outf.write('\t')
        outf.write('\n')

if __name__=="__main__":
    main()
    
