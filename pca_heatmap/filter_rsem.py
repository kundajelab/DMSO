#data=open('rsem.results','r').read().strip().split('\n')
data=open('rsem.expected_count.tsv','r').read().strip().split('\n')
outf=open('rsem.expected_count.filtered.tsv','w')
outf.write(data[0]+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    vals=[float(i) for i in tokens[1::]]
    if max(vals)==0:
        continue
    outf.write(line+'\n')
    
