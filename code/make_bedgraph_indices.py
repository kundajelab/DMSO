#generates indices for bedgraph test data 
positions=open("/srv/scratch/annashch/stemcells/het/anna_all_timepoint_pairs/aggregate_pangwei.SLICED.tsv",'r').read().split("\n") 
while '' in positions: 
    positions.remove('') 
pos_dict=dict() 
for line in positions[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    startpos=int(tokens[1])-400 
    endpos=int(tokens[2])+400 
    peak=tokens[3] 
    pos_dict[peak]=tuple([chrom,str(startpos),str(endpos)])
#testPeaks=open("/srv/scratch/annashch/deeplearning/heterokaryon/inputs/heterokaryon.sliding.pangwei.1.roi.test.txt",'r').read().split('\n')
testPeaks=open("/srv/scratch/annashch/deeplearning/heterokaryon/inputs/heterokaryon.sliding.pangwei.1.test.txt",'r').read().split('\n')
while '' in testPeaks: 
    testPeaks.remove('') 
outf=open('bedgraph_heterokaryon.txt','w') 
for peak in testPeaks: 
    outf.write('\t'.join(pos_dict[peak])+'\n')


