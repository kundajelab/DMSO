import sys 
data=open(sys.argv[1],'r').read().strip().split('\n')
states=open('state_map.txt').read().strip().split('\n')
state_dict=dict()
for line in states:
    tokens=line.split('\t')
    state_dict[tokens[0]]=tokens[1]
tally_dict=dict() 
outf=open(sys.argv[1]+'.tally','w')
for line in data:
    tokens=line.split('\t')
    state=state_dict[tokens[-1]]
    if state not in tally_dict:
        tally_dict[state]=1
    else:
        tally_dict[state]+=1
for state in tally_dict:
    outf.write(state+'\t'+str(tally_dict[state])+'\n')

