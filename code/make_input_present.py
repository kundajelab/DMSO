outf=open('presence_tasks.txt','w') 
outf_stringent=open('presence_tasks_stringent.txt','w') 
outf.write('Chrom\tStart\tEnd\tControl\tDMSO\n')
outf_stringent.write('Chrom\tStart\tEnd\tControl\tDMSO\n')

merged=open('all_peaks.merged','r').read().split('\n') 
idr_merged_overlap=open('all_peaks_in_idr_and_naive','r').read().split('\n') 
idr_merged_overlap_dict=dict()
for line in idr_merged_overlap: 
    idr_merged_overlap_dict[line]=1 


while '' in merged: 
    merged.remove('') 

control=open('Control.present','r').read().split('\n') 
while '' in control: 
    control.remove('') 
control_dict=dict() 
control_idr_dict=dict() 
for line in control: 
    control_dict[line]=1 
    if line in idr_merged_overlap_dict: 
        control_idr_dict[line]=1 

dmso=open('DMSO.present','r').read().split('\n') 
while '' in dmso: 
    dmso.remove('') 
dmso_dict=dict() 
dmso_idr_dict=dict() 
for line in dmso: 
    dmso_dict[line]=1 
    if line in idr_merged_overlap_dict: 
        dmso_idr_dict[line]=1 


for line in merged: 
    outf.write(line) 
    outf_stringent.write(line) 
    if (line in control_dict) and (line in control_idr_dict): 
        outf.write('\t1')
        outf_stringent.write('\t1') 
    elif line in control_dict: 
        outf.write('\t1') 
        outf_stringent.write('\t-1') 
    else: 
        outf.write('\t0') 
        outf_stringent.write('\t0') 
    if (line in dmso_dict) and (line in dmso_idr_dict):
        outf.write('\t1') 
        outf_stringent.write('\t1') 
    elif line in dmso_dict: 
        outf.write('\t1') 
        outf_stringent.write('\t-1')         
    else: 
        outf.write('\t0') 
        outf_stringent.write('\t0') 
    outf.write('\n')
    outf_stringent.write('\n') 


