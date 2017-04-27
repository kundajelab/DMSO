import sys
import operator 
data=open(sys.argv[1],'r').read().strip().split('\n')
outf=open(sys.argv[1]+'.filtered','w')
count=0
#sort the results
sorted_results=dict() 
for line in data:
    if line.startswith('#'):
        if count<4:
            outf.write(line+'\n')
    else:
        tokens=line.split('\t')
        hyperbonferoni=float(tokens[14])
        if hyperbonferoni < 0.05:
            sorted_results[line]=hyperbonferoni
    count+=1

sorted_x = sorted(sorted_results.items(), key=operator.itemgetter(1))
for entry in sorted_x:
    outf.write(entry[0]+'\n')
    
