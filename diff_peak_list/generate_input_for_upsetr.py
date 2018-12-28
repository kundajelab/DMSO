outf=open('upsetr.peak.input.txt','w')
outf.write('Gene\tearlyG1Up\tlateG1Up\tSG2MUp\tearlyG1Down\tlateG1Down\tSG2MDown\n')
data_dict=dict()
data=open('earlyG1.up.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['earlyG1']=1
data=open('earlyG1.down.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['earlyG1']=-1
data=open('lateG1.up.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['lateG1']=1
data=open('lateG1.down.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['lateG1']=-1
data=open('SG2M.up.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['SG2M']=1
data=open('SG2M.down.bed','r').read().strip().split('\n')
for gene in data:
    if gene not in data_dict:
        data_dict[gene]=dict()
    data_dict[gene]['SG2M']=-1
    
for gene in data_dict:
    outf.write(gene)
    if 'earlyG1' in data_dict[gene]:
        if (data_dict[gene]['earlyG1']==1):
            outf.write('\t'+str(data_dict[gene]['earlyG1']))
        else:
            outf.write('\t0')
    else:
        outf.write('\t0')
        
    if 'lateG1' in data_dict[gene]:
        if data_dict[gene]['lateG1']==1:
            outf.write('\t'+str(data_dict[gene]['lateG1']))
        else:
            outf.write('\t0')
    else:
        outf.write('\t0')
        
    if 'SG2M' in data_dict[gene]:
        if data_dict[gene]['SG2M']==1: 
            outf.write('\t'+str(data_dict[gene]['SG2M']))
        else:
            outf.write('\t0')
    else:
        outf.write('\t0')
    if 'earlyG1' in data_dict[gene]:
        if (data_dict[gene]['earlyG1']==-1):
            outf.write('\t'+str(data_dict[gene]['earlyG1']))
        else:
            outf.write('\t0')

    else:
        outf.write('\t0')
        
    if 'lateG1' in data_dict[gene]:
        if data_dict[gene]['lateG1']==-1:
            outf.write('\t'+str(data_dict[gene]['lateG1']))
        else:
            outf.write('\t0')

    else:
        outf.write('\t0')
        
    if 'SG2M' in data_dict[gene]:
        if data_dict[gene]['SG2M']==-1: 
            outf.write('\t'+str(data_dict[gene]['SG2M']))
        else:
            outf.write('\t0')
    else:
        outf.write('\t0')
    
    outf.write('\n')
    
