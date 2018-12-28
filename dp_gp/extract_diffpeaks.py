diffpeaks=open("all.diffpeaks",'r').read().strip().split('\n')
diffpeak_dict=dict()
for line in diffpeaks:
    diffpeak_dict[line]=1
outf=open("fold_change_atac.dpgp.input.diffpeaks.tsv",'w')
fc=open('fold_change_atac.dpgp.input.tsv','r').read().strip().split('\n')
outf.write(fc[0]+'\n')
for line in fc[1::]:
    tokens=line.split('\t')
    peakname=tokens[0]
    if peakname in diffpeak_dict:
        outf.write(line+'\n')
        
