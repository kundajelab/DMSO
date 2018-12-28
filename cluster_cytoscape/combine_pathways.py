import argparse
import pandas as pd

def parse_args():
    parser=argparse.ArgumentParser(description="Generate Bar Graph of Enriched GO Terms")
    parser.add_argument("--enriched_terms_files",nargs="+")
    parser.add_argument("--cluster_labels",nargs="+")
    parser.add_argument("--out_prefix")
    return parser.parse_args()

def main():
    args=parse_args()
    term_dict=dict()
    gene_to_term=dict()
    gene_to_file=dict() 
    terms=set([])
    files=args.enriched_terms_files 
    for fname in args.enriched_terms_files:
        data=pd.read_table(fname,header=0,sep='\t')
        for index,row in data.iterrows():
            term=row['GeneSet']
            fdr=row['FDR']
            nodes=row['Nodes'] 
            if term not in term_dict:
                term_dict[term]=dict()
            term_dict[term][fname]=fdr
            terms.add(term)
            for gene in nodes.split(','): 
                if gene not in gene_to_file:
                    gene_to_file[gene]=dict()
                if gene not in gene_to_term:
                    gene_to_term[gene]=dict() 
                gene_to_file[gene][fname]=1
                gene_to_term[gene][term]=1
    outf_pathways=open(args.out_prefix+".enriched.pathways.txt",'w')
    outf_pathways.write('Pathway\t'+'\t'.join(files)+'\n')
    for term in terms:
        outf_pathways.write(term)
        for filename in files:
            if filename in term_dict[term]:
                outf_pathways.write('\t'+str(term_dict[term][filename]))
            else:
                outf_pathways.write('\tNA')
        outf_pathways.write('\n')
    outf_gene_to_file=open(args.out_prefix+".gene_to_file.txt",'w')
    outf_gene_to_term=open(args.out_prefix+".gene_to_term.txt",'w')
    outf_gene_to_file.write('Gene\t'+'\t'.join(files)+'\n')
    for gene in gene_to_file:
        outf_gene_to_file.write(gene)
        for filename in files:
            if filename in gene_to_file[gene]:
                outf_gene_to_file.write('\t1')
            else:
                outf_gene_to_file.write('\t0')
        outf_gene_to_file.write('\n')
    outf_gene_to_term.write('Gene\tTerm\n')
    for gene in gene_to_term:
        for term in gene_to_term[gene]:
            outf_gene_to_term.write(gene+'\t'+term+'\n')
            
                        
if __name__=="__main__":
    main()
    
