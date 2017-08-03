targets=open('extract.gene','r').read().strip().split('\n')
outf=open('extract.gene.filled','w')
data=open('differential_expressed_gene_tad_distribution.txt','r').read().strip().split('\n')
target_dict=dict()
for line in targets:
    target_dict[line]=1
for line in data:
    tokens='\t'.join(line.split('\t')[0:3])
    if tokens in target_dict:
        target_dict[tokens]=line.split('\t')[-1] 
for t in targets:
    outf.write(t+'\t'+str(target_dict[t])+'\n')
    
        
    
