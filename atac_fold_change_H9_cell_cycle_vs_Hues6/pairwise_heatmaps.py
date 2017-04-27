import numpy as np 
#data=open('macs.fc.rounded.cellcycleonly.averaged.reps.tsv','r').read().strip().split('\n')
data=open('macs.fc.rounded.averaged.reps.tsv','r').read().strip().split('\n')
header='Gene'+'\t'+'\t'.join(data[0].split('\t')[4::])
#lateG1 vs SG2M
up_hues6_earlyg1=open('Up_hues6_and_earlyG1_DMSO.txt','w')
up_hues6_earlyg1.write(header+'\n') 
up_hues6_lateg1=open('Up_hues6_and_lateG1_DMSO.txt','w')
up_hues6_lateg1.write(header+'\n') 
up_hues6_sg2m=open('Up_hues6_and_SG2M_DMSO.txt','w')
up_hues6_sg2m.write(header+'\n') 
down_hues6_earlyg1=open('Down_hues6_and_earlyG1_DMSO.txt','w')
down_hues6_earlyg1.write(header+'\n') 
down_hues6_lateg1=open('Down_hues6_and_lateG1_DMSO.txt','w')
down_hues6_lateg1.write(header+'\n') 
down_hues6_sg2m=open('Down_hues6_and_SG2M_DMSO.txt','w')
down_hues6_sg2m.write(header+'\n')

for line in data[1::]:
    tokens=line.split('\t')
    print(str(tokens))
    gene=tokens[0:4] 
    val=[float(i) for i in tokens[4::]]
    logvals=[]
    for i in val:
        if i >0:
            logvals.append(np.log2(i))
        else:
            logvals.append(0)
    #get the fold changes of interest
    #hues6
    if val[-2]==0:
        hues6_fc=val[-1]
    else:
        hues6_fc=val[-1]/val[-2]
    if hues6_fc >0:
        hues6_fc=np.log2(hues6_fc)
    if abs(hues6_fc)<1:
        continue
    #earlyG1
    if val[0]==0:
        earlyG1_fc=val[3]
    else:
        earlyG1_fc=val[3]/val[0]
    if earlyG1_fc >0:
        earlyG1_fc=np.log2(earlyG1_fc)
    #lateG1
    if val[1]==0:
        lateG1_fc=val[4]
    else:
        lateG1_fc=val[4]/val[1]
    if lateG1_fc >0:
        lateG1_fc=np.log2(lateG1_fc)

    #SG2M
    if val[2]==0:
        SG2M_fc=val[5]
    else:
        SG2M_fc=val[5]/val[2]
    if SG2M_fc >0:
        SG2M_fc=np.log2(SG2M_fc)

    if (hues6_fc >=1) and (earlyG1_fc >=1):
        up_hues6_earlyg1.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')
    elif(hues6_fc <=-1) and (earlyG1_fc<=-1):
        down_hues6_earlyg1.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')

    if (hues6_fc >=1) and (lateG1_fc >=1):
        up_hues6_lateg1.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')
    elif(hues6_fc <=-1) and (lateG1_fc<=-1):
        down_hues6_lateg1.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')

    if (hues6_fc >=1) and (SG2M_fc >=1):
        up_hues6_sg2m.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')
    elif(hues6_fc <=-1) and (SG2M_fc<=-1):
        down_hues6_sg2m.write(' '.join(tokens[0:4])+'\t'+'\t'.join(tokens[4::])+'\n')
