import argparse
import pandas as pd

def parse_args():
    parser=argparse.ArgumentParser("")
    parser.add_argument("--in_f",nargs="+")
    parser.add_argument("--out_f")
    return parser.parse_args()

def main():
    args=parse_args()
    pos_averages=dict()
    for f_name in args.in_f:
        print(f_name)
        data=pd.read_table(f_name,header=None,sep='\t')
        for index,row in data.iterrows():
            offset=row[3]
            coverage=row[4]
            if offset not in pos_averages:
                pos_averages[offset]=dict()
            if f_name not in pos_averages[offset]:
                pos_averages[offset][f_name]=[coverage]
            else:
                pos_averages[offset][f_name].append(coverage)
    print("parsed all positions")
    outf=open(args.out_f,'w')
    positions=list(pos_averages.keys())
    samples=args.in_f
    outf.write('Position'+'\t'+'\t'.join(samples)+'\n')
    for position in positions:
        outf.write(str(position))
        for sample in samples:
            mean_coverage=sum(pos_averages[position][sample])/len(pos_averages[position][sample])
            outf.write('\t'+str(mean_coverage))
        outf.write('\n')
        
    
if __name__=="__main__":
    main()
    
