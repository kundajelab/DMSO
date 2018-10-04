#averages replicates for differential genes
data=open("new_RSEM.tpm.corrected",'r').read().strip().split('\n')
outf=open("new_RSEM.tpm.corrected.averagedrep",'w')
outf.write("Gene\tearlyG1.control\tlateG1.control\tSG2M.control\tearlyG1.DMSO\tlateG1.DMSO\tSG2M.DMSO\n")
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    values=[float(i) for i in tokens[1::]]
    earlyG1_control=str(sum(values[0:2])/2)
    lateG1_control=str(sum(values[2:4])/2)
    SG2M_control=str(sum(values[4:6])/2)
    earlyG1_dmso=str(sum(values[6:8])/2)
    lateG1_dmso=str(sum(values[8:10])/2)
    SG2M_dmso=str(sum(values[10:12])/2)
    outf.write('\t'.join([gene,earlyG1_control,lateG1_control,SG2M_control,earlyG1_dmso,lateG1_dmso,SG2M_dmso])+'\n')
