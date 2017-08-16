import sys
data=open(sys.argv[1],'r').read().strip().split('\n')
tally=dict()
header=data[0].split('\t')
header_dict=dict()
for i in range(len(header)):
    header_dict[i]=header[i]
for line in data[1::]:
    tokens=line.split('\t')
    for i in range(3,len(tokens)):
        cur_score=float(tokens[i])
        if cur_score>0:
            motif_hit=header_dict[i]
            if motif_hit not in tally:
                tally[motif_hit]=1 
            else:
                tally[motif_hit]+=1
outf=open(sys.argv[2],'w')
for entry in tally:
    outf.write(entry+'\t'+str(tally[entry])+'\n')
    
