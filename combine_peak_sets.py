merged_peak_set=open("chetty_chipseq_aggregate_files_merged_narrowPeak.bed").read().strip().split('\n') 
individual_files=open("file_list.txt",'r').read().strip().split('\n') 
peaks=dict() 
for fname in individual_files: 
    data=open(fname,'r').read().strip().split('\n') 
    peaks[fname]=dict() 
    for line in data: 
        tokens=line.split('\t') 
        pos='\t'.join(tokens[1:4])
        val=tokens[0]
        peaks[fname][pos]=val 
print('made peak dictionaries') 
samples=peaks.keys() 
outf=open("chipseq_merged.txt",'w') 
outf.write('Chrom\tStart\tEnd\t'+'\t'.join(samples)+'\n')
for line in merged_peak_set: 
    outf.write(line) 
    for sample in samples: 
        if line in peaks[sample]: 
            outf.write('\t'+peaks[sample][line])
        else: 
            outf.write('\t1')
    outf.write('\n') 

    
    
