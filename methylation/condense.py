#data=open('atac.hits','r').read().strip().split('\n')
data=open('accessible_earlyg1_differential_late/chip.hits','r').read().strip().split('\n')
#outf=open('atac.hits.condensed','w')
outf=open('accessible_earlyg1_differential_late/chip.hits.condensed','w')
for line in data:
    tokens=line.split('\t')
    name='_'.join(tokens[0:4])
    vals='\t'.join(tokens[4::])
    outf.write(name+'\t'+vals+'\n')
    
