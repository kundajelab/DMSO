prefixes=['earlyG1.down','earlyG1.up','lateG1.down','lateG1.up','SG2M.down','SG2M.up']
#prefixes=['quies']
outf=open('15_all_states.tally.txt','w')
#outf=open('quies.tally.txt','w')
tally_dict=dict()
for p in prefixes:
    data=open(p+'.annotation.filtered','r').read().strip().split('\n')
    for line in data:
        tokens=line.split('\t')
        state=tokens[3]
        if state not in tally_dict:
            tally_dict[state]=dict()
        if p not in tally_dict[state]:
            tally_dict[state][p]=1
        else:
            tally_dict[state][p]+=1
outf.write('State'+'\t'+'\t'.join(prefixes)+'\n')
for state in tally_dict:
    outf.write(state)
    for p in prefixes:
        if p in tally_dict[state]:
            outf.write('\t'+str(tally_dict[state][p]))
        else:
            outf.write('\t0')
    outf.write('\n')
    
    
