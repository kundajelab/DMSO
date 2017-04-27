data=open('dmso.regression.input.sorted.overlapped','r').read().strip().split('\n') 
outf=open('dmso.regression.input.sorted.overlapped.uniq','w')
data_dict=dict() 
for line in data: 
    tokens=line.split('\t') 
    entry=tuple(tokens[0:3])
    print str(entry) 
    if entry not in data_dict: 
        data_dict[entry]=[] 
    val=tokens[6] 
    if val=='.': 
        val=0 
    else: 
        val=float(val) 
    data_dict[entry].append(val)
for entry in data_dict: 
    pos='\t'.join([str(i) for i in entry])
    val=sum(data_dict[entry])/len(data_dict[entry])
    outf.write(pos+'\t'+str(val)+'\n')

