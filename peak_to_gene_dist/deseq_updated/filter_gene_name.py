data=open("all.diffgene.coords.tsv",'r').read().strip().split('\n')
outf=open('tmp','w')
for line in data:
    tokens=line.split('\t')
    geneinfo=tokens[-1].split(';')
    genename=None
    for entry in geneinfo:
        if entry.startswith("Parent"):
            genename=entry.split(':')[-1]
            break 
        elif entry.startswith('ENS'):
            genename=entry
            break
        elif entry.startswith('ID=gene'):
            genename=entry.split(':')[-1]
    if genename==None:
        print(line)
    outf.write(tokens[0]+'\t'+tokens[1]+'\t'+tokens[2]+'\t'+genename+'\n')
    
    
