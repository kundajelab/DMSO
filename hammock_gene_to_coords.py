import sys
data=open(sys.argv[1],'r').read().strip().split('\n')
coords=open(sys.argv[2],'r').read().strip().split('\n')
coord_dict=dict()
for line in coords:
    tokens=line.split('\t')
    gene=tokens[-1]
    coord_dict[gene]=tokens[0:-1]
outf=open(sys.argv[1]+'.mapped','w')
for line in data:
    tokens=line.split('\t')
    gene=tokens[0]
    coords=coord_dict[gene]
    outf.write('\t'.join(coords)+'\t'+'\t'.join(tokens[1::])+'\n')
    
