import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="combine path,gene,peak,state info into a single summary")
    parser.add_argument("--pathway_to_gene")
    parser.add_argument("--gene_to_peak")
    parser.add_argument("--chrom_hmm_state_map")
    parser.add_argument("--chrom_hmm_annotation")
    parser.add_argument("--label")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    path_to_gene=open(args.pathway_to_gene,'r').read().strip().split('\n')
    gene_to_peak=open(args.gene_to_peak,'r').read().strip().split('\n')
    chrom_hmm_state_map=open(args.chrom_hmm_state_map,'r').read().strip().split('\n')
    chrom_hmm_annotation=open(args.chrom_hmm_annotation,'r').read().strip().split('\n')
    label=args.label

    gene_to_peak_dict=dict()
    for line in gene_to_peak[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        peak=tokens[1:]
        if len(peak)>3:
            peak=peak[0:4]
        if gene not in gene_to_peak_dict:
            gene_to_peak_dict[gene]=dict()
        if 'peaks' not in gene_to_peak_dict[gene]:
            gene_to_peak_dict[gene]['peaks']=[peak]
        else:
            gene_to_peak_dict[gene]['peaks'].append(peak)
    print("made gene_to_peak dict")

    for line in path_to_gene[1::]:
        tokens=line.split('\t')
        path=tokens[0]
        genes=tokens[-1].split(',')
        for gene in genes:
            if gene not in gene_to_peak_dict:
                gene_to_peak_dict[gene]=dict()
            if 'path' not in gene_to_peak_dict[gene]:
                gene_to_peak_dict[gene]['path']=[path] 
            else:
                gene_to_peak_dict[gene]['path'].append(path)
    print("made path to gene dict")


    hmm_state_dict=dict() 
    for line in chrom_hmm_state_map:
        tokens=line.split('\t')
        hmm_state_dict[tokens[0]]=tokens[-2]

    chrom_hmm_dict=dict()
    for line in chrom_hmm_annotation:
        tokens=line.split('\t')
        peak='_'.join(tokens[0:3])
        state=hmm_state_dict[tokens[-1]]
        chrom_hmm_dict[peak]=state

    print("made peak_to_state_dict")
    outf=open(args.outf,'w')
    for gene in gene_to_peak_dict:
        if 'path' in gene_to_peak_dict[gene]:
            cur_path='|'.join(gene_to_peak_dict[gene]['path'])
        else:
            cur_path='NA'
        if 'peaks' in gene_to_peak_dict[gene]:
            for peak in gene_to_peak_dict[gene]['peaks']:
                peak_name=peak[0]
                peak_state=chrom_hmm_dict[peak_name]
                outf.write(gene+'\t'+label+'\t'+cur_path+'\t'+'\t'.join(peak)+'\t'+peak_state+'\n')
        else:
            outf.write(gene+'\t'+label+'\t'+cur_path+'\n')
    
if __name__=="__main__":
    main()
    
