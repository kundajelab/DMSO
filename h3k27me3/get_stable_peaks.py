import pdb 
allpeaks=set(open('h3k27me3.naiveoverlap.bed').read().strip().split('\n'))
diff_peaks=set(open('differential').read().strip().split('\n'))
delta=allpeaks.difference(diff_peaks)
pdb.set_trace()

outf=open('h3k27me3_stable.bed','w')
outf.write('\n'.join(delta))

