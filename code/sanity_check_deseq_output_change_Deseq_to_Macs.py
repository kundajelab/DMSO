#This file takes the output from Deseq2 and adjusts it. I.e. if a peak is present at 3hr , absent at 16hr but Deseq2 gives 0, we need to adjust that to -1. 
data=open('diffMatAnna.binarized.combined.thresholded.tsv','r').read().split('\n') 
outf=open('diffMatAnna.binarized.combined.thresholded.adjusted.tsv','w') 
outf.write(data[0]+'\n')
header=data[0].split('\t') 
header_dict=dict() 
inverse_header_dict=dict() 
for i in range(len(header)): 
    header_dict[header[i]]=i 
    inverse_header_dict[i]=header[i] 
print str(header_dict) 
print str(inverse_header_dict) 


for line in data[1::]: 
    tokens=line.split('\t') 
    output='\t'.join(tokens[0:4])  
    for i in range(4,len(tokens)): 
        curheader=inverse_header_dict[i].split('.')
        direction=None 
        if len(curheader) >1:
            direction=curheader[1] 
        curheader=curheader[0].split('_') 
        curvalue=tokens[i] 
        if (len(curheader)>1) and (curvalue == "0"): 
            #print "checking!!" 
            first=curheader[0] 
            second=curheader[1] 
            if(first in header_dict) and (second in header_dict): 
                #we can adjust!
                first_index=header_dict[first] 
                second_index=header_dict[second] 
                first_val=tokens[first_index] 
                second_val=tokens[second_index] 
                #print first_val + " " +second_val 
                #1->0
                if ((first_val=="1") and (second_val=="0")) and (direction=="Up"): 
                    curvalue="1" 
                    print "ADJUSTING UP!!" 
                #0->1 
                elif ((first_val=="0") and (second_val=="1")) and (direction=="Down"): 
                    curvalue="1" 
                    print "ADJUSTING DOWN!!" 
        output=output+'\t'+curvalue 
    outf.write(output+'\n') 

