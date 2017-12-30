#prefixes=['earlyG1.down','earlyG1.up','lateG1.down','lateG1.up','SG2M.down','SG2M.up']
prefixes=['cluster_1','cluster_2','cluster_4','cluster_6']
outf=open('all_states.tally.txt','w')
tally_dict=dict()
for p in prefixes:
    data=open(p+'.chromHMM.anno.tally','r').read().strip().split('\n')
    for line in data:
        tokens=line.split('\t')
        state=tokens[0]
        numpeaks=tokens[1]
        if state not in tally_dict:
            tally_dict[state]=dict()
        tally_dict[state][p]=numpeaks
outf.write('State'+'\t'+'\t'.join(prefixes)+'\n')
for state in tally_dict:
    outf.write(state)
    for p in prefixes:
        if p in tally_dict[state]:
            outf.write('\t'+tally_dict[state][p])
        else:
            outf.write('\t0')
    outf.write('\n')
    
    
