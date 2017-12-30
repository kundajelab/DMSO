prefixes=['earlyG1.down','earlyG1.up','lateG1.down','lateG1.up','SG2M.down','SG2M.up']
for p in prefixes:
    data=open(p+'.annotation','r').read().strip().split('\n')
    states=dict()
    for line in data:
        tokens=line.split('\t')
        peak=tuple(tokens[1:4])
        new_overlap=int(tokens[-1])
        new_state=tokens[0] 
        if peak not in states:
            states[peak]=[new_state,new_overlap]
        else:
            old_state=states[peak][0]
            old_overlap=states[peak][1]
            if old_state=="15_Quies":
                states[peak]=[new_state,new_overlap]
            elif new_state!="15_Quies":
                if new_overlap > old_overlap:
                    states[peak]=[new_state,new_overlap]
    outf=open(p+'.annotation.filtered','w')
    for peak in states:
        outf.write('\t'.join(peak)+'\t'+states[peak][0]+'\n')
        
