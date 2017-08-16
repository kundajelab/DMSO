import sys
data=open(sys.argv[1]).read().strip().split('\n')
outf=open(sys.argv[2],'w')
index=0
for line in data:
    outf.write(str(index)+'\t'+line+'\n')
    index+=1
