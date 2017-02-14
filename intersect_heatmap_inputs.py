import argparse
import sys
import pdb

def parse_args():
    parser=argparse.ArgumentParser(description="intersect chipseq, rnaseq, atac seq heatmaps based on gene column")
    parser.add_argument("--heatmap_inputs",nargs="+")
    parser.add_argument("--gene_column",nargs="+")
    parser.add_argument("--outf")
    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1) 
    return parser.parse_args() 
def main():
    args=parse_args()
    print(str(args))
    gene_to_val=dict()
    num_files=len(args.heatmap_inputs)
    header=""
    for i in range(len(args.heatmap_inputs)):
        data=open(args.heatmap_inputs[i],'r').read().strip().split('\n')
        header=header+'\t'+data[0] 
        for line in data[1::]:
            tokens=line.split('\t')
            gene=tokens[int(args.gene_column[i])]
            gene=[g.split(' ')[0] for g in gene.split(',')]
            for g in gene:
                if g not in gene_to_val:
                    gene_to_val[g]=[None]*num_files
                if gene_to_val[g][i]==None:
                    gene_to_val[g][i]=[line]
                else:
                    gene_to_val[g][i].append(line)
    #take the intersection
    outf=open(args.outf,'w')
    outf.write(header+'\n') 
    for gene in gene_to_val:
        if gene_to_val[gene].count(None)==0:
            #present in each dataset!
            max_hit=max([len(g_hits) for g_hits in gene_to_val[gene]])
            entry_lengths=[]
            for dataset_hits in gene_to_val[gene]:
                entry_lengths.append(len(dataset_hits[0].split('\t'))) 
            print(str(entry_lengths))
            for j in range(max_hit):
                for g_hit_index in range(len(gene_to_val[gene])):
                    g_hit=gene_to_val[gene][g_hit_index]
                    if len(g_hit)> j:
                        outf.write('\t'+g_hit[j])
                    else:
                        outf.write('\t'*entry_lengths[g_hit_index])
                outf.write('\n')
                
        
if __name__=="__main__":
    main() 
