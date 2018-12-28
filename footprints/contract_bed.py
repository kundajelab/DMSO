#contracts bed file to just the start position  or end position for 5' cuts pileup
import argparse
import pandas as pd 
def parse_args():
    parser=argparse.ArgumentParser(description="contract or expand bed file (or tagAlign) to get 5' or 3' cuts")
    parser.add_argument("--inputf")
    parser.add_argument("--strand",help="one of 'forward' or 'reverse'")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    data=pd.read_table(args.inputf,header=None,sep='\t')
    outf=open(args.outf,'w')
    print("loaded data")
    if args.strand=="forward":
        data[2]=data[1]
    elif args.strand=="reverse":
        data[1]=data[2]
    data.to_csv(args.outf,sep='\t',header=False,index=False)
    
        
if __name__=="__main__":
    main()
    
