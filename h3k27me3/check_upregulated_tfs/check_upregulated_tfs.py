#checks enriched tf's for differential gene expression from RNA-seq data
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="check enriched tf's for differential gene expression from RNA-seq data")
    parser.add_argument("--motif_hits_h3k27me3")
    parser.add_argument("--earlyG1_df")
    parser.add_argument("--lateG1_df")
    parser.add_argument("--SG2M_df")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    earlyg1=open(args.earlyG1_df,'r').read().strip().split('\n')
    lateg1=open(args.lateG1_df,'r').read().strip().split('\n')
    sg2m=open(args.SG2M_df,'r').read().strip().split('\n')
    #create a dictionary of genes w/ differential expression values in given timepoints
    data_dict=dict()
    data_dict['earlyG1']=earlyg1
    data_dict['lateG1']=lateg1
    data_dict['sg2m']=sg2m
    diff_dict=dict()
    all_genes=dict()
    
    for timepoint in data_dict:
        for line in data_dict[timepoint][1::]:
            tokens=line.split('\t')
            gene=tokens[0]
            fc=float(tokens[1])
            adj_pval=float(tokens[-1])
            #check for significance
            if ((abs(fc)>=1) and (adj_pval<=0.05)):
                if gene not in diff_dict:
                    diff_dict[gene]=dict()
                else:
                    diff_dict[gene][timepoint]=[fc,adj_pval]
            if gene not in all_genes:
                all_genes[gene]=dict()
            else:
                all_genes[gene][timepoint]=[fc,adj_pval]
                
    print("generated differential dict")
    motif_hits=open(args.motif_hits_h3k27me3,'r').read().strip().split('\n')

    #write differential TF's to output file
    outf=open(args.outf,'w')
    outf.write(motif_hits[0]+'\t'+'earlyG1_fc'+'\t'+'earlyG1_pval'+'\t'+'lateG1_fc'+'\t'+'lateG1_pval'+'\t'+'SG2M_fc'+'\t'+'SG2M_pval'+'\n')
    outf_missing=open(args.outf+'.missing','w')
    outf_missing.write(motif_hits[0]+'\n')    
    
    for line in motif_hits[1::]:
        tokens=line.split('\t')
        motif=tokens[0].upper()
        if motif in diff_dict:
            outf.write('\t'.join(tokens))
            earlyG1_fc='NA'
            earlyG1_pval='NA'
            if 'earlyG1' in diff_dict[motif]:
                earlyG1_fc=str(diff_dict[motif]['earlyG1'][0])
                earlyG1_pval=str(diff_dict[motif]['earlyG1'][1])
            outf.write('\t'+earlyG1_fc+'\t'+earlyG1_pval)
                
            lateG1_fc='NA'
            lateG1_pval='NA'
            if 'lateG1' in diff_dict[motif]:
                lateG1_fc=str(diff_dict[motif]['lateG1'][0])
                lateG1_pval=str(diff_dict[motif]['lateG1'][1])
            outf.write('\t'+lateG1_fc+'\t'+lateG1_pval)
                
            SG2M_fc='NA'
            SG2M_pval='NA'
            if 'SG2M' in diff_dict[motif]:
                SG2M_fc=str(diff_dict[motif]['SG2M'][0])
                SG2M_pval=str(diff_dict[motif]['SG2M'][1])
            outf.write('\t'+SG2M_fc+'\t'+SG2M_pval)
            outf.write('\n')
        elif (motif not in all_genes) :
            outf_missing.write(line+'\n')
            
    
    
if __name__=="__main__":
    main()
    
    
