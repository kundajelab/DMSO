#converts the output of limma voom differential analysis to a hammock file
import argparse
import json
import sys

def parse_args():
    parser=argparse.ArgumentParser(description="Provide a .tsv file containing limma voom analysis result to generate hammock track that can be visualized in Washu browser")
    parser.add_argument('--voom_file',help='limma voom file in tab-separated format')
    parser.add_argument('--output_file',help='name of output file to generate')
    parser.add_argument('--coord_column',help='name of column header in voom file that stores the chromosome_start_end coordinates')
    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1) 
    return parser.parse_args()
def main():
    args=parse_args()
    data=open(args.voom_file).read().strip().split('\n')
    header=data[0].replace('"','').split('\t')
    print(str(header))
    coord_index=header.index(args.coord_column)
    outf=open(args.output_file,'w')
    peak_id=0
    output_data=[] 
    for line in data[1::]:
        line=line.replace('"','') 
        tokens=line.split('\t')
        coords=tokens[coord_index].split('_')
        out_string='\t'.join(coords)
        hammock_vals=dict()
        hammock_vals['details']=dict() 
        hammock_vals['id']=peak_id
        peak_id+=1
        for i in range(len(header)):
            if i ==coord_index:
                continue
            else:
                hammock_vals['details'][header[i]]=float(tokens[i])
        hammock_vals=json.dumps(hammock_vals).strip('{').strip('}')
        out_string=out_string+'\t'+hammock_vals
        output_data.append(out_string)
    outf.write('\n'.join(output_data))
    

if __name__=="__main__":
    main() 
