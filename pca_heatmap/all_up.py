data=open('alltasks.filtered.txt','r').read().strip().split('\n')
outf=open('DMSO_all_up.txt','w')
outf.write(data[0]+'\n')
for line in data[1::]:
    tokens=line.split('\t') 
    part=[int(i) for i in tokens[15:21]]
    minpart=min(part)
    if minpart==1:
        outf.write(line+'\n')
        
    
