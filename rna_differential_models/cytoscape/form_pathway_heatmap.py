import math
gene_dict=dict()
print('earlyg1.up')
earlyg1_up=open('earlyG1.up.table.txt','r').read().strip().split('\n')
for line in earlyg1_up[1::]:
    tokens=line.split(',')
    print(str(tokens))
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['earlyG1.Up.DMSO']=fdr

print('earlyg1.down') 
earlyg1_down=open('earlyG1.down.table.txt','r').read().strip().split('\n')
for line in earlyg1_down[1::]:
    tokens=line.split(',')
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['earlyG1.Down.DMSO']=fdr

print('lateg1.up') 
lateg1_up=open('lateG1.up.table.txt','r').read().strip().split('\n')
for line in lateg1_up[1::]:
    tokens=line.split(',')
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['lateG1.Up.DMSO']=fdr

print('lateg1.down') 
lateg1_down=open('lateG1.down.table.txt','r').read().strip().split('\n')
for line in lateg1_down[1::]:
    tokens=line.split(',')
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['lateG1.Down.DMSO']=fdr

print('sg2m.up') 
sg2m_up=open('SG2M.up.table.txt','r').read().strip().split('\n')
for line in sg2m_up[1::]:
    tokens=line.split(',')
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['SG2M.Up.DMSO']=fdr

print('sg2m.down')
sg2m_down=open('SG2M.down.table.txt','r').read().strip().split('\n')
for line in sg2m_down[1::]:
    tokens=line.split(',')
    path=tokens[0]
    fdr=-10*math.log10(float(tokens[5]))
    if path not in gene_dict:
        gene_dict[path]=dict()
    gene_dict[path]['SG2M.Down.DMSO']=fdr

outf=open('pathways.txt','w')
outf.write('Pathway\tearlyG1.up.DMSO\tearlyG1.down.DMSO\tlateG1.up.DMSO\tlateG1.down.DMSO\tSG2M.up.DMSO\tSG2M.down.DMSO\n')
keys=['earlyG1.Up.DMSO','earlyG1.Down.DMSO','lateG1.Up.DMSO','lateG1.Down.DMSO','SG2M.Up.DMSO','SG2M.Down.DMSO']
for pathway in gene_dict:
    outf.write(pathway)
    for key in keys:
        if key in gene_dict[pathway]:
            outf.write('\t'+str(gene_dict[pathway][key]))
        else:
            outf.write('\t0')
    outf.write('\n')
    
