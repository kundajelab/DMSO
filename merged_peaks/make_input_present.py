outf=open('presence_tasks.txt','w')
outf_stringent=open('presence_tasks_stringent.txt','w')  

samples=["earlyG1_R1_controls","earlyG1_R1_treated","earlyG1_R2_controls","earlyG1_R2_treated","lateG1_R1_controls","lateG1_R1_treated","lateG1_R2_controls","lateG1_R2_treated","SG2M_R1_controls","SG2M_R1_treated","SG2M_R2_controls","SG2M_R2_treated"] 
outf.write('Chrom\tStart\tEnd') 
outf_stringent.write('Chrom\tStart\tEnd') 
for s in samples: 
    outf.write('\t'+s)
    outf_stringent.write('\t'+s) 
outf.write('\n') 
outf_stringent.write('\n') 

merged=open('ppr.merged.bed','r').read().strip().split('\n') 
ppr_dict=dict() 
idr_dict=dict() 
for sample in samples: 
    ppr_dict[sample]=dict() 
    idr_dict[sample]=dict() 
    ppr_data=open(sample+'.ppr.bed','r').read().strip().split('\n') 
    for line in ppr_data: 
        ppr_dict[sample][line]=1 

    idr_data=open(sample+'.idr.bed','r').read().strip().split('\n')  
    for line in idr_data: 
        idr_dict[sample][line]=1 

for line in merged: 
    outf.write(line) 
    for sample in samples: 
        if line in ppr_dict[sample]: 
            outf.write('\t1') 
        else: 
            outf.write('\t0') 
    outf.write('\n')

#STRINGENT!
for line in merged: 
    outf_stringent.write(line) 
    for sample in samples: 
        if line in idr_dict[sample]: 
            outf_stringent.write('\t1') 
        elif line in ppr_dict[sample]: 
            outf_stringent.write('\t-1') 
        else: 
            outf_stringent.write('\t0') 
    outf_stringent.write('\n')

