#computes an intersection of differential regions across two timepoints in the dmso & control samples
import argparse
import sys

def parse_args():
    parser=argparse.ArgumentParser(description="computes an intersection of differential regions across two timepoints in the dmso & control samples")
    parser.add_argument("--dmso_file")
    parser.add_argument("--control_file")
    parser.add_argument("--outf")
    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1) 
    return parser.parse_args() 

def main():
    args=parse_args()
    outf=open(args.outf,'w')
    dmso_data=open(args.dmso_file,'r').read().strip().split('\n')
    control_data=open(args.control_file,'r').read().strip().split('\n')
    pos_to_val=dict()
    for line in dmso_data[1::]:
        tokens=line.split('\t')
        pos=tokens[-1]
        vals='\t'.join([str(i) for i in [round(float(i),2) for i in tokens[0:-1]]])
        pos_to_val[pos]=[vals,None]
    for line in control_data[1::]:
        tokens=line.split('\t')
        pos=tokens[-1]
        vals='\t'.join([str(i) for i in [round(float(i),2) for i in tokens[0:-1]]])
        if pos not in pos_to_val:
            pos_to_val[pos]=[None,vals]
        else:
            pos_to_val[pos][1]=vals
    header_dmso='\t'.join(dmso_data[0].split('\t')[0:-1])
    header_control='\t'.join(control_data[0].split('\t')[0:-1])
    num_fields_dmso=len(header_dmso.split('\t'))
    num_fields_control=len(header_control.split('\t'))
    outf.write("Position\t"+header_dmso+'\t\t'+header_control+'\n')
    positions=pos_to_val.keys()
    positions.sort()
    for position in positions:
        outf.write(position) 
        if pos_to_val[position][0]!=None:
            outf.write('\t'+pos_to_val[position][0])
        else:
            outf.write('\t'*num_fields_dmso)
        outf.write('\t')
        if pos_to_val[position][1]!=None:
            outf.write('\t'+pos_to_val[position][1])
        else:
            outf.write('\t'*num_fields_control)
        outf.write('\n')
                       
if __name__=="__main__":
    main() 
