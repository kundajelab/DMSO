import sys
data=open(sys.argv[1],'r').read().strip().split('\n')
state_map=open("../state_map.txt",'r').read().strip().split('\n')
state_dict=dict()
for line in state_map:
    tokens=line.split('\t')
    state_dict[tokens[0]]=tokens[-1]
print(str(state_dict))
outf=open(sys.argv[1]+'.formatted','w')
for line in data:
    tokens=line.split('\t')
    color=state_dict[tokens[2]]
    outf.write(tokens[3]+'\t'+tokens[4]+'\t'+tokens[5]+'\t'+'color='+color+'\n')
    
