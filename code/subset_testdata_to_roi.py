import sys 
from Params import * 
from generateSplits import * 

peaklist=open(sys.argv[1],'r').read().split('\n') 
while '' in peaklist: 
    peaklist.remove('') 
peakdict=dict() 
for line in peaklist: 
    peakdict[line]=1 

peak_pos=open('/srv/scratch/annashch/stemcells/het/anna_all_timepoint_pairs/aggregate_pangwei.SLICED.tsv','r').read().split('\n')  
peak_pos.remove('') 

outf=open(sys.argv[2],'w') 
pluripotency_dict = make_pluripotency_dict(pluripotency_region_file, pluripotent_region_flank)
for line in peak_pos[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    startpos=int(tokens[1]) 
    endpos=int(tokens[2]) 
    peak_name=tokens[3] 
    #is the peak in our test set? 
    if peak_name not in peakdict: 
        continue 
    print "chrom:"+str(chrom) 
    print "startpos:"+str(startpos) 
    print "endpos:"+str(endpos) 
    #is the peak in a pluripotency region? 
    inpluripotentregion=isPeakInPluripotencyRegion(pluripotency_dict,chrom,startpos,endpos) 
    print str(inpluripotentregion) 
    if inpluripotentregion: 
        outf.write(peak_name+'\n')
