data=open('distances.bed','r').read().strip().split('\n') 
hit_dict=dict() 
outf=open('filtered.distances.bed','w') 
for line in data: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    peak_start=tokens[1] 
    peak_end=tokens[2] 
    dist=int(tokens[-1]) 
    entry=tuple([chrom,peak_start,peak_end])
    if entry in hit_dict: 
        if abs(dist) < abs(hit_dict[entry][0]): 
            hit_dict[entry]=[dist,line] 
    else: 
        hit_dict[entry]=[dist,line] 
for key in hit_dict: 
    outf.write(hit_dict[key][1]+'\n')

