prefixes=['earlyG1.down','earlyG1.up','lateG1.down','lateG1.up','SG2M.down','SG2M.up']
flank=400
for p in prefixes:
    data=open(p+'.sorted','r').read().strip().split('\n')
    outf=open(p+'.sorted.extraflank','w')
    for line in data:
        tokens=line.split('\t')
        start=int(tokens[1])-flank
        end=int(tokens[2])+flank
        outf.write(tokens[0]+'\t'+str(start)+'\t'+str(end)+'\n')
        
