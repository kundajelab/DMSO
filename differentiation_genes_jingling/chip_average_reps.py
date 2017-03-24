import numpy as np 
data=open('chipseq_merged.txt','r').read().split('\n')
header=data[0].split('\t')
outf=open('chipseq_merged.averaged.txt','w')
outf.write('Chrom\tStart\tEnd\tH3K27ac_control\tH3K27ac_DMSO\tH3K4me3_Control\tH3K4me3_DMSO\tH3K27me3_Control\tH3K27me3_DMSO\n')
for line in data[1::]:
    tokens=line.split('\t')
    if len(tokens)==0:
        continue
    gene='\t'.join(tokens[0:3])
    vals=[float(i) for i in tokens[3::] ]
    #print(str(vals))
    #if max(vals)<1:
    #    continue
    c_h3k27ac=0.5*sum([vals[10],vals[11]])
    t_h3k27ac=0.5*sum([vals[0],vals[2]])
    c_h3k4me3=0.5*sum([vals[5],vals[6]])
    t_h3k4me3=0.5*sum([vals[7],vals[9]])
    c_h3k27me3=0.5*sum([vals[3],vals[4]])
    t_h3k27me3=0.5*sum([vals[1],vals[8]])
    
    outf.write(gene+'\t'+'\t'.join([str(i) for i in [c_h3k27ac,t_h3k27ac,c_h3k4me3,t_h3k4me3,c_h3k27me3,t_h3k27me3]])+'\n')
