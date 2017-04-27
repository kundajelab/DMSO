header="1\t3\nbigwig/Heterokaryon.bw:bigwig:{\"local_norm_halfwidth\":10000}\n" 
#all_labels=open("diffMatAnna.binarized.combined.thresholded.tsv",'r').read().strip().split('\n') 
#sampled_labels=open("/srv/scratch/annashch/deeplearning/heterokaryon/inputs/newpeaks.long.labels.txt",'r').read().strip().split('\n') 
#all_labels=open('specialized_peaks.SLICED.tsv','r').read().strip().split('\n') 
all_labels=open('dmso.regression.labels.named','r').read().strip().split('\n') 
sampled_labels=open('/srv/scratch/annashch/deeplearning/dmso/inputs/regression.labels.txt','r').read().strip().split('\n') 
sampled_dict=dict() 
for line in sampled_labels[1::]: 
    tokens=line.split('\t')
    peakname=tokens[0].split('_') 
    if len(peakname)==3: 
        peakname='_'.join(peakname[0:2])
    else: 
        peakname='_'.join(peakname) 
    sampled_dict[peakname]=line  
print str(sampled_dict.keys()[0:10])
print "made label dict" 
file_dict=dict()
hits=0  
for line in all_labels[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    start=int(tokens[1])  
    end=int(tokens[2])
    target=2000 
    observed=end-start 
    toadd=target-observed 
    flank=toadd/2 
    start=start-flank 
    end=end+flank
    if (end-start)!=2000: 
        start=start-1 
    if start<1: 
        start=1 
    peak=tokens[3]
    proxychrom="all" 
    if peak in sampled_dict: 
        hits+=1 
        print str(hits) 
        if proxychrom not in file_dict:
            file_dict[proxychrom]=open(proxychrom+'.gdl','w') 
            file_dict[proxychrom].write(header) 
        file_dict[proxychrom].write(chrom+'\t'+str(start)+'\t'+str(end)+'\t'+sampled_dict[peak]+'\n')
 

