data=open("atac_corrected.averaged.csv",'r').read().strip().split('\n')
print("loaded differential peaks")
header=data[0].split('\t')
samples=header[3::]
outputs=[]
for s in samples:
    outputs.append(open(s+'.peak.bedGraph','w'))
print("generated output files to fill")
for line in data[1::]:
    tokens=line.split('\t')
    cur_coords='\t'.join(tokens[0:3])
    for i in range(3,len(tokens)):
        outputs[i-3].write(cur_coords+'\t'+str(round(float(tokens[i]),2))+'\n')

