import argparse
import math

def parse_args():
    parser=argparse.ArgumentParser(description="generate rank files for GSEA from limma output")
    parser.add_argument("--inputf")
    parser.add_argument("--column",type=int)
    parser.add_argument("--out_prefix")
    return parser.parse_args()

def main():
    args=parse_args()
    data=open(args.inputf,'r').read().strip().split('\n')
    all_ranks=dict()
    up_ranks=dict()
    down_ranks=dict()    
    #rank all by -10*log10(adjusted p-value)
    #split into upregulated and downregulated groups of genes
    for line in data[1::]:
        tokens=line.split('\t')
        gene=tokens[0] 
        fc=float(tokens[args.column])
        p_val=-10*math.log10(float(tokens[-1]))
        if p_val not in all_ranks:
            all_ranks[p_val]=[gene]
        else:
            all_ranks[p_val].append(gene)
        if fc > 0:
            if p_val not in up_ranks:
                up_ranks[p_val]=[gene]
            else:
                up_ranks[p_val].append(gene)
        else:
            if p_val not in down_ranks:
                down_ranks[p_val]=[gene]
            else:
                down_ranks[p_val].append(gene)
    outf=open(args.out_prefix+".all",'w')
    for key in all_ranks:
        for value in all_ranks[key]:
            outf.write(value+'\t'+str(round(key,3))+'\n')
    outf=open(args.out_prefix+".up",'w')
    for key in up_ranks:
        for value in up_ranks[key]:
            outf.write(value+'\t'+str(round(key,3))+'\n')
    outf=open(args.out_prefix+".down",'w')
    for key in down_ranks:
        for value in down_ranks[key]:
            outf.write(value+'\t'+str(round(key,3))+'\n')

    
    
    
    
if __name__ == "__main__":
    main()
    
