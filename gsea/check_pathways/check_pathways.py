import argparse
import pdb 
def parse_args():
    parser=argparse.ArgumentParser(description="check if genes from pathway are found by GSEA, Limma, or both")
    parser.add_argument("--quantized_earlyG1")
    parser.add_argument("--quantized_lateG1")
    parser.add_argument("--quantized_SG2M") 
    parser.add_argument("--pathway")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    
    quantized_earlyG1=open(args.quantized_earlyG1,'r').read().strip().split('\n')
    quantized_lateG1=open(args.quantized_lateG1,'r').read().strip().split('\n')
    quantized_SG2M=open(args.quantized_SG2M,'r').read().strip().split('\n')
    
    pathways=open(args.pathway,'r').read().strip().split('\n')
    quantized_dict=dict()

    quantized_dict['earlyg1']=dict() 
    for line in quantized_earlyG1:
        tokens=line.split('\t')
        direction=tokens[0]
        foundby=tokens[1]
        genes=tokens[2::]
        if direction not in quantized_dict['earlyg1']:
            quantized_dict['earlyg1'][direction]=dict()
        for gene in genes:
            quantized_dict['earlyg1'][direction][gene]=foundby
        

    quantized_dict['lateg1']=dict() 
    for line in quantized_lateG1:
        tokens=line.split('\t')
        direction=tokens[0]
        foundby=tokens[1]
        genes=tokens[2::]
        if direction not in quantized_dict['lateg1']:
            quantized_dict['lateg1'][direction]=dict()
        for gene in genes:
            quantized_dict['lateg1'][direction][gene]=foundby
        

    quantized_dict['sg2m']=dict() 
    for line in quantized_SG2M:
        tokens=line.split('\t')
        direction=tokens[0]
        foundby=tokens[1]
        genes=tokens[2::]
        if direction not in quantized_dict['sg2m']:
            quantized_dict['sg2m'][direction]=dict()
        for gene in genes:
            quantized_dict['sg2m'][direction][gene]=foundby
        
    outf=open(args.outf,'w')
    outf.write(pathways[0]+'\n')
    for line in pathways[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        time=tokens[1]
        direction=tokens[2]
        if direction =="":
            direction=tokens[3]
        if direction=="1":
            direction="Up"
        elif direction=="-1":
            direction="Down"
        else:
            raise Exception()
        if gene not in quantized_dict[time][direction]:
            cur_foundby="None"
        else:
            cur_foundby=quantized_dict[time][direction][gene]
        outf.write(line+'\t'+cur_foundby+'\n')
        
if __name__=="__main__":
    main()
    
