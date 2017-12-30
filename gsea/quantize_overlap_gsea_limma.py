import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="compare hits from limma v/ GSEA")
    parser.add_argument("--comparison_file")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    comparison=open(args.comparison_file,'r').read().strip().split('\n')
    
    gsea_sig_up=[]
    limma_sig_up=[]
    gsea_sig_down=[]
    limma_sig_down=[]
    gsea_dict_up=dict()
    gsea_dict_down=dict()
    
    for line in comparison[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        gsea_score=float(tokens[4])
        if gsea_score > 0:
            if gsea_score not in gsea_dict_up:
                gsea_dict_up[gsea_score]=[gene]
            else:
                gsea_dict_up[gsea_score].append(gene)
        else:
            if gsea_score not in gsea_dict_down:
                gsea_dict_down[gsea_score]=[gene]
            else:
                gsea_dict_down[gsea_score].append(gene)        
        fc=float(tokens[5])
        pval=float(tokens[-1])        
        if pval<=0.05:
            if fc >=1:
                limma_sig_up.append(gene)
            elif fc <=-1:
                limma_sig_down.append(gene)
    num_sig_down=len(limma_sig_down)
    num_sig_up=len(limma_sig_up)

    print(str(num_sig_up))
    print(str(num_sig_down))
    #get the gsea scores
    gsea_up_keys=gsea_dict_up.keys()
    gsea_up_keys.sort(reverse=True)
    gsea_down_keys=gsea_dict_down.keys()
    gsea_down_keys.sort()
        
    for up_key in gsea_up_keys:
        cur_genes=gsea_dict_up[up_key]
        gsea_sig_up=gsea_sig_up+cur_genes
        if len(gsea_sig_up)>=num_sig_up:
            break
        
    for down_key in gsea_down_keys:
        cur_genes=gsea_dict_down[down_key]
        gsea_sig_down=gsea_sig_down+cur_genes
        if len(gsea_sig_down)>=num_sig_down:
            break
        
    #intersect the gene sets!
    limma_sig_up=set(limma_sig_up)
    limma_sig_down=set(limma_sig_down)
    gsea_sig_up=set(gsea_sig_up)
    gsea_sig_down=set(gsea_sig_down)

    common_up=limma_sig_up.intersection(gsea_sig_up)
    common_down=limma_sig_down.intersection(gsea_sig_down)
    limma_up_only=limma_sig_up-gsea_sig_up
    gsea_up_only =gsea_sig_up-limma_sig_up
    limma_down_only=limma_sig_down-gsea_sig_down
    gsea_down_only=gsea_sig_down-limma_sig_down

    outf=open(args.outf,'w')
    outf.write('Up\tCommon\t'+'\t'.join(list(common_up))+'\n')
    outf.write('Down\tCommon\t'+'\t'.join(list(common_down))+'\n')
    outf.write('Up\tLimma\t'+'\t'.join(list(limma_up_only))+'\n')
    outf.write('Down\tLimma\t'+'\t'.join(list(limma_down_only))+'\n')
    outf.write('up\tGSEA\t'+'\t'.join(list(gsea_up_only))+'\n')
    outf.write('Down\tGSEA\t'+'\t'.join(list(gsea_down_only))+'\n')
    
    outf=open(args.outf+'.summary','w')
    outf.write('Up\tCommon\t'+str(len(common_up))+'\n')
    outf.write('Down\tCommon\t'+str(len(common_down))+'\n')
    outf.write('Up\tLimma\t'+str(len(limma_up_only))+'\n')
    outf.write('Down\tLimma\t'+str(len(limma_down_only))+'\n')
    outf.write('Up\tGSEA\t'+str(len(gsea_up_only))+'\n')
    outf.write('Down\tGSEA\t'+str(len(gsea_down_only))+'\n')
    
    
    
if __name__=="__main__":
    main()
    
