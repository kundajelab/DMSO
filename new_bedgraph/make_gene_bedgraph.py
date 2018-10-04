#generate bedgraph of corrected gene expression
data=open("new_RSEM.tpm.corrected.averagedrep.diff",'r').read().strip().split('\n')
print("loaded corrected RSEM values") 

header=data[0].split('\t')
samples=header[1::]
outputs=[]
for s in samples:
    outputs.append(open(s+'.gene.bedGraph','w'))
print("generated output files to fill") 

gene_coords=open("gene_coords.txt",'r').read().strip().split('\n')
gene_coord_dict=dict()
for line in gene_coords:
    tokens=line.split('\t')
    gene=tokens[-1]
    gene_coord_dict[gene]='\t'.join(tokens[0:3])
print("made coord dict")

for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    try:
        cur_coords=gene_coord_dict[gene]
    except:
        gene=tokens[0].split('-')[0]
        cur_coords=gene_coord_dict[gene]
    for i in range(1,len(tokens)):
        outputs[i-1].write(cur_coords+'\t'+str(max([0,round(float(tokens[i]),2)]))+'\n')
        
