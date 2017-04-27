data=open('rsem.fold.change.tsv','r').read().strip().split('\n')
outf_early_up=open('upregulated_earlyG1.tsv','w')
outf_early_down=open('downregulated_earlyG1.tsv','w')
outf_late_up=open('upregulated_lateG1.tsv','w')
outf_late_down=open('downregulated_lateG1.tsv','w')
outf_sg2m_up=open('upregulated_SG2M.tsv','w')
outf_sg2m_down=open('downregulated_SG2M.tsv','w')
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    vals=[float(i) for i in tokens[1::]]
    if vals[0]>=1:
        outf_early_up.write(gene+'\n')
    if vals[0]<=-1:
        outf_early_down.write(gene+'\n')
    if vals[1]>=1:
        outf_late_up.write(gene+'\n')
    if vals[1]<=-1:
        outf_late_down.write(gene+'\n')
    if vals[2]>=1:
        outf_sg2m_up.write(gene+'\n')
    if vals[2]<=-1:
        outf_sg2m_down.write(gene+'\n')
    
