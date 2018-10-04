from pybedtools import BedTool
import pdb
h9=BedTool("E008_15_coreMarks_dense.bed.gz")
hues6=BedTool("E015_15_coreMarks_dense.bed.gz")
print("loaded BedFiles for h9 & hues6")


chromsizes=open("hg19.chrom.sizes",'r').read().strip().split('\n')
window=2000
results=dict()
h9_states=set([])
hues6_states=set([])

for line in chromsizes:
    tokens=line.split('\t')
    chrom=tokens[0]
    size=int(tokens[1])
    intervals=BedTool('\n'.join([chrom+'\t'+str(i)+'\t'+str(i+window) for i in range(1,size+2000,2000)]),from_string=True)
    print("generated intervals for chromosome:"+str(chrom))
    #get the intersection with each histone mark.
    intersection_h9=intervals.intersect(h9,wao=True)
    intersection_hues6=intervals.intersect(hues6,wao=True)    
    print("got intersections with histone marks")
    intersection_h9=[str(i).split('\t') for i in intersection_h9]
    intersection_hues6=[str(i).split('\t') for i in intersection_hues6]
    for i in range(len(intervals)):
        cur_state_h9=intersection_h9[i][6]
        h9_states.add(cur_state_h9) 
        cur_state_hues6=intersection_hues6[i][6]
        hues6_states.add(cur_state_hues6)
        
        transition=(cur_state_h9,cur_state_hues6)
        if cur_state_h9 not in results:
            results[cur_state_h9]=dict()
        if cur_state_hues6 not in results[cur_state_h9]:
            results[cur_state_h9][cur_state_hues6]=1
        else:
            results[cur_state_h9][cur_state_hues6]+=1
outf=open("h9_hues6_transitions.txt",'w')
h9_states=list(h9_states)
hues6_states=list(hues6_states)
outf.write('\t'+'\t'.join(hues6_states)+'\n')
for s in h9_states:
    outf.write(s)
    for e in hues6_states:
        outf.write('\t'+str(results[s][e]))
    outf.write('\n')
    
