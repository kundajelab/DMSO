#generates a summary for each model on a given dataset
#gets total number of up/down regulated genes by task
#gets total number of genes across lists of interest (i.e. differentiation & cell adhesion)
import argparse
import pdb
def parse_args():
    parser=argparse.ArgumentParser(description="total number of up/down genes for each model & gene list of interest")
    parser.add_argument("--models",nargs="+")
    parser.add_argument("--gene_sets",nargs="*")
    parser.add_argument("--task_names",nargs="+")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    gene_set_dict=dict()
    for gene_set_file in args.gene_sets:
        gene_set=open(gene_set_file,'r').read().strip().split('\n')
        mini_dict=dict()
        for gene in gene_set:
            mini_dict[gene]=1 
        gene_set_dict[gene_set_file]=mini_dict 
    print('imported gene sets of interest')
    summary=dict()
    tasks=args.task_names
    for task in tasks:
        summary[task]=dict()
        summary[task]['total']=dict()
        summary[task]['total']['up']=dict()
        summary[task]['total']['down']=dict()
        for model in args.models:
            summary[task]['total']['up'][model]=0
            summary[task]['total']['down'][model]=0
            
        for gene_set in args.gene_sets:
            summary[task][gene_set]=dict()
            summary[task][gene_set]['up']=dict()
            summary[task][gene_set]['down']=dict()
            for model in args.models:
                summary[task][gene_set]['up'][model]=0
                summary[task][gene_set]['down'][model]=0
            
    for model in args.models:
        data=open(model,'r').read().strip().split('\n')
        for line in data[1::]:
            tokens=line.split('\t')
            gene=tokens[0]
            for i in range(1,len(tokens)):
                cur_task=tasks[i-1]
                cur_val=float(tokens[i])
                if cur_val ==1:
                    #add to task total for upregulated genes!
                    summary[cur_task]['total']['up'][model]+=1
                    #check each of the gene sets
                    for gene_set in gene_set_dict:
                        if gene in gene_set_dict[gene_set]:
                            summary[cur_task][gene_set]['up'][model]+=1 
                elif cur_val==-1:
                    #add to task total for downregulated genes!
                    summary[cur_task]['total']['down'][model]+=1
                    #check each of the gene sets
                    for gene_set in gene_set_dict:
                        if gene in gene_set_dict[gene_set]:
                            summary[cur_task][gene_set]['down'][model]+=1
    print("finished summarizing model!!")
    print(str(summary))
    outf=open(args.outf,'w')
    outf.write('Task\tGeneSet\tDirection\t'+'\t'.join(args.models)+'\n')
    for task in summary:
        for gene_set in summary[task]:
            for direction in summary[task][gene_set]:
                outf.write(task+'\t'+gene_set+'\t'+direction+'\t')
                for model in args.models:
                    outf.write('\t'+str(summary[task][gene_set][direction][model]))
                outf.write('\n')
                               
if __name__=="__main__":
    main()
    
