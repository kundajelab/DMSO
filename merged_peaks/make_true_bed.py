import sys 
data=open(sys.argv[1],'r').read().strip().split('\n') 
outf=open(sys.argv[2],'w') 
c=0 
for line in data: 
    outf.write(line+'\t'+'.'+'\t'+str(c)+'\t'+'.'+'\n')
    c+=1 

