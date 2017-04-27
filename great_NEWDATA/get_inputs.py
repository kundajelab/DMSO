data=open('diffMatAnna.binarized.csv','r').read().strip().split('\n') 
tasks=data[0].split('\t')
task_dict=dict() 
for i in range(3,len(tasks)): 
    task_dict[tasks[i]]=[] 
for line in data[1::] : 
    tokens=line.split('\t') 
    entry='\t'.join(tokens[0:3]) 
    for i in range(3,len(tokens)): 
        if tokens[i]=="1": 
            #add to dict! 
            task_dict[tasks[i]].append(entry)
for i in range(3,len(tasks)): 
    outf=open(tasks[i],'w') 
    outf.write('\n'.join(task_dict[tasks[i]]))

