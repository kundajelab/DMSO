data=open('hg19.gff','r').read().strip().split('\n') 
outf=open('hg19.gff.filtered','w') 
data_dict=dict() 
for line in data: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    startpos=tokens[1] 
    endpos=tokens[2] 
    entry=tuple([chrom,startpos,endpos])
    if entry in data_dict: 
        continue 
    else: 
        outf.write(line+'\n') 
        data_dict[entry]=1 

