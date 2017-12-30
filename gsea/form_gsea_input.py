import numpy as np 
data=open('../rsem.expected_count.tsv','r').read().split('\n')
#header=data[0].split('\t')
#outf=open('rsem.gsea.input.txt','w')
#outf.write('Name\tDescription\tControl_earlyG1\tControl_lateG1\tControl_SG2M\tDMSO_earlyG1\tDMSO_lateG1\tDMSO_SG2M\n')
#for line in data[1::]:
#    tokens=line.split('\t')
#    if (len(tokens)<2):
#        continue
#    gene=tokens[0]
#    vals=[float(i) for i in tokens[1::] ]
#    print(str(vals))
#    #if max(vals)<1:
#    #    continue 
#    c_early=0.5*sum([vals[0],vals[1]])
#    c_late=0.5*sum([vals[2],vals[3]])
#    c_sg2m=0.5*sum([vals[4],vals[5]])
#    t_early=0.5*sum([vals[6],vals[7]])
#    t_late=0.5*sum([vals[8],vals[9]])
#    t_sg2m=0.5*sum([vals[10],vals[11]])
#    outf.write(gene+'\t'+'na'+'\t'+'\t'.join([str(i) for i in [c_early,c_late,c_sg2m,t_early,t_late,t_sg2m]])+'\n')
#

data=open('rsem.expected_count.tsv','r').read().split('\n')
header=data[0].split('\t')
outf=open('rsem.gsea.input.reps.txt','w')
outf.write('Name\tDescription\t'+'\t'.join(header[1::])+'\n')
for line in data[1::]:
    tokens=line.split('\t')
    if (len(tokens)<2):
        continue
    gene=tokens[0]
    vals=tokens[1::]
    print(str(vals))
    outf.write(gene+'\t'+'na'+'\t'+'\t'.join(vals)+'\n')
    
