import argparse
import pandas as pd 
def parse_args():
    parser=argparse.ArgumentParser(description="tally chromHMM annotations")
    parser.add_argument("--files",nargs="+")
    parser.add_argument("--outf")
    parser.add_argument("--state_map",default="15_state_map.txt")
    return parser.parse_args()
def main():
    args=parse_args()
    tally_dict=dict()
    states=open(args.state_map,'r').read().strip().split('\n')
    for line in states:
        state=line.split('\t')[0]
        tally_dict[state]=dict()
    for f in args.files:
        for state in tally_dict:
            tally_dict[state][f]=0 
        data=pd.read_table(f,header=None,sep='\t')
        for index,row in data.iterrows():
            cur_state=row[3]
            tally_dict[cur_state][f]+=1
    outf=open(args.outf,'w')
    outf.write('State'+'\t'+'\t'.join(args.files)+'\n')
    for state in tally_dict:
        outf.write(state)
        for f in args.files:
            outf.write('\t'+str(tally_dict[state][f]))
        outf.write('\n')
        

if __name__=="__main__":
    main()
    
