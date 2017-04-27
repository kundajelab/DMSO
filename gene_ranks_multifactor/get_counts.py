import os
allfiles=os.listdir('/srv/scratch/annashch/dmso/gene_ranks_multifactor')
outf=open('all.counts.txt','w')
outf.write('Sample\tUp\tDown\n')
for f in allfiles:
    if f.endswith('.RANKED'):
        data=open(f,'r').read().strip().split('\n')
        upcount=0
        downcount=0
        for line in data[1::]:
            fc=float(line.split('\t')[-1])
            if fc > 0:
                upcount+=1
            else:
                downcount+=1
        outf.write(f+'\t'+str(upcount)+'\t'+str(downcount)+'\n')
        
