#reorders the rows (usu. genes) of a given matrix
import argparse
import sys
def parse_args():
    parser=argparse.ArgumentParser(description="order matrix rows, i.e. for heatmap input")
    parser.add_argument("--input_matrix")
    parser.add_argument("--line_order_file")
    parser.add_argument("--outf")
    return parser.parse_args()
def main():
    args=parse_args()
    data=open(args.input_matrix,'r').read().strip().split('\n')
    order=open(args.line_order_file,'r').read().strip().split('\n')
    outf=open(args.outf,'w')
    outf.write(data[0]+'\n') 
    for element in order:
        for line in data[1::]:
            if line.__contains__(element):
                outf.write(line+'\n')
                
if __name__=="__main__":
    main()
    
