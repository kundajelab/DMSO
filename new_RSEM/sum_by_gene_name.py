data=open("rsem.genes.tpm",'r').read().strip().split('\n')
data_dict=dict()
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    values=[float(i) for i in tokens[1::]]
    if gene not in data_dict:
        data_dict[gene]=values
    else:
        current_sum=data_dict[gene]
        new_sum=[x+y for x,y in zip(current_sum,values)]
        data_dict[gene]=new_sum
outf=open("tmp",'w')
outf.write(data[0]+'\n')
for gene in data_dict:
    outf.write(gene+'\t'+'\t'.join([str(i) for i in data_dict[gene]])+'\n')
    
