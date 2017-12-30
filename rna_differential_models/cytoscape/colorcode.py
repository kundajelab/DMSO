#combine gene expression profiles to generate a color-code for the cytoscape network.
file_groups=['earlyG1.up.txt','earlyG1.down.txt','lateG1.up.txt','lateG1.down.txt','SG2M.up.txt','SG2M.down.txt']
gene_dict=dict()
expression_matrix=dict()
for fname in file_groups:
    data=open(fname,'r').read().strip().split('\n')
    for gene in data:
        if gene not in gene_dict:
            gene_dict[gene]=fname
        else:
            gene_dict[gene]=gene_dict[gene]+'_'+fname
        fname_parts=fname.split('.')
        condition=fname_parts[0]
        if fname_parts[1]=="up":
            direction=1
        else:
            direction=-1
        if gene not in expression_matrix:
            expression_matrix[gene]=dict()
        expression_matrix[gene][condition]=direction



outf=open('annotated_geneset.collapsed.txt','w')
for gene in gene_dict:
    outf.write(gene+'\t'+gene_dict[gene]+'\n')
outf=open('annotated_geneset.txt','w')
outf.write('Gene\tearlyG1\tlateG1\tSG2M\n')
for gene in expression_matrix:
    outf.write(gene)
    for timepoint in ['earlyG1','lateG1','SG2M']:
        if timepoint in expression_matrix[gene]:
            cur_value=expression_matrix[gene][timepoint]
        else:
            cur_value=0
        outf.write('\t'+str(cur_value))
    outf.write('\n')
    
