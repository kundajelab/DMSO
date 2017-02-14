#helper script to define a specific order of matrix columns
import argparse
import sys 
def parse_args():
    parser=argparse.ArgumentParser(description="order matrix columns,i.e. for heatmap input")
    parser.add_argument("--inputf",help="matrix file in tsv format")
    parser.add_argument("--orderf",help="file with list of column headers in desired order")
    parser.add_argument("--outf",help="output filename")
    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1)
    return parser.parse_args()
def main():
    args=parse_args()
    data=open(args.inputf,'r').read().strip().split('\n')
    outf=open(args.outf,'w')
    order=open(args.orderf,'r').read().strip().split('\n') 
    header=data[0].split('\t')
    order_indices=dict()
    for element in order:
        element_index=header.index(element)
        order_indices[element]=element_index
    outf.write('\t'.join(order)+'\n')
    for line in data[1::]:
        tokens=line.split('\t')
        for i in range(1,len(tokens)):
            tokens[i]=round(float(tokens[i]),2)
        out_string=[] 
        for element in order:
            out_string.append(tokens[order_indices[element]])
        outf.write('\t'.join([str(i) for i in out_string])+'\n')
            

if __name__=="__main__":
    main() 
