import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="compare RSEM vs KALLISTO differential genes")
    parser.add_argument("--rsem_folder")
    parser.add_argument("--kallisto_folder")
    parser.add_argument("--gene_set_file_names",nargs="+") 
    parser.add_argument("--outf")
    return parser.parse_args()

def overlap_gene_sets(rsem_genes,kallisto_genes):
    rsem_genes=set([i.split('_')[-1] for i in rsem_genes])
    kallisto_genes=set([i.split('_')[-1] for i in kallisto_genes])
    
    num_rsem=len(rsem_genes)
    num_kallisto=len(kallisto_genes)
    num_common=len(rsem_genes.intersection(kallisto_genes))
    num_rsem_only=len(rsem_genes-kallisto_genes)
    num_kallisto_only=len(kallisto_genes-rsem_genes)
    return [num_rsem,num_kallisto,num_common,num_rsem_only,num_kallisto_only]
    
def main():
    args=parse_args()
    outf=open(args.outf,'w')
    outf.write('Comparison\tRSEM_total\tKALLISTO_total\tCommon_RSEM_and_KALLISTO\tRSEM_only\tKALLISTO_only\n')
    for filename in args.gene_set_file_names:
        rsem_genes=open('/'.join([args.rsem_folder,filename]),'r').read().strip().split('\n')
        kallisto_genes=open('/'.join([args.kallisto_folder,filename]),'r').read().strip().split('\n')
        overlap_results=overlap_gene_sets(rsem_genes,kallisto_genes)
        outf.write(filename+'\t'+'\t'.join([str(i) for i in overlap_results])+'\n')
        

if __name__=="__main__":
    main()
    
    
