 #annotate the nodes and edges for inclusion in concentric circles figure
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="generate nodes and edges files for input to Cytoscape")
    parser.add_argument("--pathway_to_gene")
    parser.add_argument("--gene_to_peak")
    parser.add_argument("--chrom_hmm_annotation")
    parser.add_argument("--chrom_hmm_state_map")
    parser.add_argument("--outf")
    return parser.parse_args()

def main():
    args=parse_args()
    path_to_gene=open(args.pathway_to_gene,'r').read().strip().split('\n')
    gene_to_peak=open(args.gene_to_peak,'r').read().strip().split('\n')

    chrom_hmm_state_map=open(args.chrom_hmm_state_map,'r').read().strip().split('\n')
    hmm_state_dict=dict() 
    for line in chrom_hmm_state_map:
        tokens=line.split('\t')
        hmm_state_dict[tokens[0]]=tokens[1]

    chrom_hmm_annotation=open(args.chrom_hmm_annotation,'r').read().strip().split('\n')
    chrom_hmm_dict=dict()
    for line in chrom_hmm_annotation:
        tokens=line.split('\t')
        peak='_'.join(tokens[0:3])
        state=hmm_state_dict[tokens[-1]]
        chrom_hmm_dict[peak]=state

        
    outf_nodes=open(args.outf+'.node','w')
    outf_nodes.write('nodeName\tnodeType\tnodeLabel\n') 
    outf_edges=open(args.outf+'.edge','w')
    outf_edges.write('fromNode\ttoNode\tdirection\n')
    node_dict=dict()
    node_index=0 
    for line in path_to_gene[1::]:
        tokens=line.split('\t')
        pathway=tokens[0]
        fdr=tokens[5]
        genes=tokens[6].split(',')
        if pathway not in node_dict:
            node_dict[pathway]=node_index
            outf_nodes.write(str(node_index)+'\t'+'Pathway'+'\t'+pathway+'\n') 
            node_index+=1
        pathway_node_index=node_dict[pathway]
        for gene in genes:
            if gene not in node_dict:
                node_dict[gene]=node_index
                outf_nodes.write(str(node_index)+'\t'+'Gene'+'\t'+gene+'\n') 
                node_index+=1                
            gene_node_index=node_dict[gene]
            outf_edges.write(str(pathway_node_index)+'\t'+str(gene_node_index)+'\t'+'directed'+'\n')
    for line in gene_to_peak[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        if gene not in node_dict:
            node_dict[gene]=node_index
            outf_nodes.write(str(node_index)+'\t'+'Gene'+'\t'+gene+'\n')
            node_index+=1
        gene_node_index=node_dict[gene]
        peak=tokens[1]
        if peak not in node_dict:
            node_dict[peak]=node_index
            outf_nodes.write(str(node_index)+'\t'+chrom_hmm_dict[peak]+'\t'+peak+'\n')
            node_index+=1
        peak_node_index=node_dict[peak]
        outf_edges.write(str(gene_node_index)+'\t'+str(peak_node_index)+'\t'+'directed'+'\n')
        if len(tokens)<5:
            continue 
        motif=tokens[4]
        if motif not in node_dict:
            node_dict[motif]=node_index
            outf_nodes.write(str(node_index)+'\t'+'Motif'+'\t'+motif+'\n')
            node_index+=1
        motif_node_index=node_dict[motif]
        outf_edges.write(str(peak_node_index)+'\t'+str(motif_node_index)+'\t'+'directed'+'\n')
        
        
        

if __name__=="__main__":
    main()
    
    
    
