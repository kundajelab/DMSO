outf=open('diff.gene.input.venn.txt','w')
outf.write('Gene\tearlyG1\tlateG1\tSG2M\n')
data_dict=dict()
data=open('earlyG1.up','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['earlyG1']=1
data=open('earlyG1.down','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['earlyG1']=-1
data=open('lateG1.up','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['lateG1']=1
data=open('lateG1.down','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['lateG1']=-1
data=open('SG2M.up','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['SG2M']=1
data=open('SG2M.down','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['SG2M']=-1
    
for gene in data_dict:
    outf.write(gene)
    if 'earlyG1' in data_dict[gene]:
        outf.write('\t'+str(data_dict[gene]['earlyG1']))
    else:
        outf.write('\t0')
        
    if 'lateG1' in data_dict[gene]:
        outf.write('\t'+str(data_dict[gene]['lateG1']))
    else:
        outf.write('\t0')
        
    if 'SG2M' in data_dict[gene]:
        outf.write('\t'+str(data_dict[gene]['SG2M']))
    else:
        outf.write('\t0')
    outf.write('\n')
    
