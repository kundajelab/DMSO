data=open('counts_merged.txt','r').read().split('\n') 
while '' in data: 
    data.remove('') 
lengths=dict() 
counter=-1 
for line in data: 
    counter+=1 
    tokens=line.split(' ') 
    line_length=len(tokens) 
    if line_length==27: 
        print str(counter) 
