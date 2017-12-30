#compares the gene ranks from GSEA with gene scores/ranks from limma voom analysis.
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="compare gene ranks from GSEA and limma voom enrichment analysis")
    parser.add_argument("--gsea_output")
    parser.add_argument("--limma_output")
    parser.add_argument("--limma_fc",type=int) 
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    gsea=open(args.gsea_output,'r').read().strip().split('\n')
    limma=open(args.limma_output,'r').read().strip().split('\n')
    gsea_dict=dict()
    limma_dict=dict()
    outf=open(args.outf,'w')
    gsea_header=gsea[0]
    limma_header='log2(fc)'+'\t'+'\t'.join(limma[0].split('\t')[-4::])
    outf.write(gsea_header+'\t'+limma_header+'\n')
    for line in gsea[1::]:
        line=line.upper() 
        tokens=line.split('\t')
        gene=tokens[0]
        gsea_dict[gene]=tokens[1::]
    for line in limma[1::]:
        line=line.upper() 
        tokens=line.split('\t')       
        gene=tokens[0]
        fc=tokens[args.limma_fc] 
        vals=[fc]+tokens[-4::]
        gsea_dict[gene]=gsea_dict[gene]+vals
    for gene in gsea_dict:
        if len(gsea_dict[gene])>5:
            outf.write(gene+'\t'+'\t'.join(gsea_dict[gene])+'\n')
        
if __name__=="__main__":
    main()
    
    
