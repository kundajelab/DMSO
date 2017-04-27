rep1=open('diffMatAnnaRep1.binarized.combined.thresholded.tsv','r').read().strip().split('\n') 
rep2=open('diffMatAnnaRep2.binarized.combined.thresholded.tsv','r').read().strip().split('\n') 
task_sim=dict() 
header=rep1[0].split('\t') 
for i in range(1,len(rep1)): 
    l_rep1=rep1[i].split('\t') 
    l_rep2=rep2[i].split('\t') 
    for j in range(4,len(l_rep1)): 
        if l_rep1[j]==l_rep2[j]: 
            if j not in task_sim: 
                task_sim[j]=1 
            else: 
                task_sim[j]+=1 
numentries=float(len(rep1)-1)  
outf=open('bio_rep_agreement.txt','w') 
for entry in task_sim: 
    outf.write(header[entry]+'\t'+str(task_sim[entry]/numentries)+'\n')

