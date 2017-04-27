#shifts ATAC-seq tagAlign file as follows: 
# u just set stop = start+1 for + strand reads and start=stop-1 for - strand reads | bedtools coverage -counts
import sys 
data=open(sys.argv[1],'r')
outf=open(sys.argv[2],'w') 
line=data.readline() 
max_queue=10000
queue=""
queue_length=0 
cl=0 
while line!="": 
    cl+=1 
    if cl%100000==0: 
        print str(cl) 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    startval=int(tokens[1]) 
    endval=int(tokens[2]) 
    strand=tokens[-1] 
    if strand=="+\n" : 
        endval=startval+1
    else: 
        startval=endval-1 
    #flush if needed 
    if queue_length>max_queue: 
        outf.write(queue) 
        queue="" 
        queue_length=0 
    queue=queue+chrom+'\t'+str(startval)+'\t'+str(endval)+'\t'+tokens[-2]+'\t'+tokens[-1]
    queue_length+=1 
    line=data.readline() 
#flush the final set of data 
outf.write(queue) 

