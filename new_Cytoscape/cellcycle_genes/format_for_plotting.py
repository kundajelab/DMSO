from statistics import stdev, mean

data=open("all.rsem.txt",'r').read().strip().split('\n')
data_dict=dict()

for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    data_dict[gene]=dict()
    data_dict[gene]['eG1c']=[float(i) for i in tokens[1:3]]
    data_dict[gene]['lG1c']=[float(i) for i in tokens[3:5]]
    data_dict[gene]['SG2Mc']=[float(i) for i in tokens[5:7]]
    data_dict[gene]['eG1d']=[float(i) for i in tokens[7:9]]
    data_dict[gene]['lG1d']=[float(i) for i in tokens[9:11]]
    data_dict[gene]['SG2Md']=[float(i) for i in tokens[11:13]]
outf=open('all.rsem.transposed.txt','w')
outf.write('Gene\tState\tMean\tSD\n')
for gene in data_dict:
    for state in ['eG1c','lG1c','SG2Mc','eG1d','lG1d','SG2Md']:
        cur_mean=mean(data_dict[gene][state])
        cur_sd=stdev(data_dict[gene][state])
        outf.write(gene+'\t'+state+'\t'+str(cur_mean)+'\t'+str(cur_sd)+'\n')
        

