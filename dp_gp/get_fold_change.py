#get fold-change values for running DPGP clustering
import argparse
def parse_args():
    parser=argparse.ArgumentParser("Get fold change values for DPGP clustering")
    parser.add_argument("--normalized_cpm")
    parser.add_argument("--name_col",type=int)
    parser.add_argument("--numer",type=int,nargs="+")
    parser.add_argument("--denom",type=int,nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    data=open(args.normalized_cpm,'r').read().strip().split('\n')
    header=data[0].split('\t')
    outf=open(args.outf,'w')
    header=data[0].split('\t')
    outf.write(header[args.name_col])
    numer=args.numer
    denom=args.denom
    for i in range(len(numer)):
        cur_numer=numer[i]
        cur_denom=denom[i] 
        outf.write('\t'+header[cur_numer]+'/'+header[cur_denom])
    outf.write('\n')
    for line in data[1::]:
        tokens=line.split('\t')
        row_name=tokens[args.name_col]
        outf.write(row_name) 
        cur_numer=[float(tokens[i]) for i in numer]
        cur_denom=[float(tokens[i]) for i in denom]
        #add a pseudocount
        cur_numer=[max(1,i) for i in cur_numer]
        cur_denom=[max(1,i) for i in cur_denom]
        ratio=[]
        for i in range(len(cur_numer)):
            if cur_denom[i]==0:
                ratio.append(round(cur_numer[i],2))
            else:
                ratio.append(round(cur_numer[i]/cur_denom[i],2))
        outf.write('\t'+'\t'.join([str(i) for i in ratio])+'\n')
        
    
            
if __name__=="__main__":
    main()
    
