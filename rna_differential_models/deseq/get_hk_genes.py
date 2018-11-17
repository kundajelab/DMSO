import pdb 
data=open("rsem.genes.expected_count",'r').read().strip().split('\n')
hk_genes=open("HK_genes.txt",'r').read().strip().split('\n')
hk_dict=dict()
for line in hk_genes:
    tokens=line.split('\t')
    hk_dict[tokens[0].strip()]=1
print("made hk dict")
#pdb.set_trace()

outf=open("HK_subset.txt",'w')
for line in data[1::]:
    tokens=line.split('\t')
    idname=tokens[0].strip()
    genename=tokens[1].strip() 
    print(genename)
    #pdb.set_trace() 
    if genename in hk_dict:
        outf.write(idname+"_"+genename+"\n")
        
