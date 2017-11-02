data=open('all_differential_peaks.dpgp.input.tsv','r').read().strip().split('\n')
outf=open("all_differential_peaks.dpgp.clean.tsv",'w')
for line in data:
    tokens=line.split('\t')
    outf.write('_'.join(tokens[0:3])+'\t'+'\t'.join(tokens[3::])+'\n')
    
