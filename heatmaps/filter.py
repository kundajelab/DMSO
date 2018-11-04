hits=open('all.diffpeaks','r').read().strip().split('\n')
hit_dict=dict()
for line in hits:
    hit_dict[line]=1
print("read in hits")
normcounts=open("normcounts_from_deseq.txt",'r').read().strip().split('\n')
print("read in normcounts")
outf=open("normcounts_from_deseq.diff.txt",'w')
outf.write(normcounts[0]+'\n')
for line in normcounts:
    tokens=line.split('\t')
    if tokens[0] in hit_dict:
        outf.write(line+'\n')
        
