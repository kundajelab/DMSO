#This script compares across multiple tasks/ models for determining differential gene expression in a dataset
import argparse
import pdb
def parse_args():
    parser=argparse.ArgumentParser(description="compare across multiple models/tasks for determining differential gene expression in a dataset")
    parser.add_argument("--models",nargs="+")
    parser.add_argument("--tasks",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    models=args.models 
    for task in args.tasks:
        outf=open(args.outf+"_"+task,'w')
        outf.write('GENE'+'\t'+'\t'.join(models)+'\n')
        #dictionary maps gene--> effect in models 
        data_dict=dict() 
        for model in models:
            try:
                data=open(model+task+".tsv",'r').read().strip().replace('\"','').split('\n')
            except:
                print("not found:"+str(model)+str(task)+".tsv")
                continue 
            header=data[0].split('\t')
            try:
                gene_index=header.index("Chrom_Start_End")
            except:
                continue 
            if task in header:
                fc_index=header.index(task)
            else:
                fc_index=header.index("log2FoldChange")
            for line in data[1::]:
                tokens=line.split('\t')
                cur_gene=tokens[gene_index]
                cur_fc=float(tokens[fc_index])
                if cur_fc > 1:
                    cur_fc=1
                else:
                    cur_fc=-1
                if cur_gene not in data_dict:
                    data_dict[cur_gene]=dict()
                data_dict[cur_gene][model]=cur_fc
        print("processed task:"+str(task))
        print("condensing outputs!")
        for gene in data_dict:
            outf.write(gene)
            print(str(data_dict[gene]))
            for model in models:
                if model in data_dict[gene]:
                    outf.write('\t'+str(data_dict[gene][model]))
                else:
                    outf.write('\t0')
            outf.write('\n')
    print("processed all the tasks!")
    
    
if __name__=="__main__":
    main()
    
