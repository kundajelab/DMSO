#This file takes the output from Deseq2 and adjusts it. I.e. if a peak is present at 3hr , absent at 16hr but Deseq2 gives 0, we need to adjust that to -1. 
#data=open('aggregate_pangwei.tsv','r').read().split('\n') 
#outf=open('aggregate_pangwei.adjusted.tsv','w') 
data=open('diffMatAnna.binarized.combined.thresholded.tsv','r').read().split('\n') 
while '' in data: 
    data.remove('') 
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

flipped=0 
flippedLines=0 
for line in data[1::]: 
    tokens=line.split('\t') 
    for i in range(3,len(tokens)): 
        curheader=inverse_header_dict[i]
        curvalue=tokens[i] 
        if curheader=="3hr.CCUp": 
            if curvalue=="1": 
                tokens[5]=="1" 
        elif curheader=="3hr.CCDown": 
            if curvalue=="1": 
                tokens[4]="1" 
        elif curheader=="16hr.3hrUp": 
            if curvalue=="1": 
                tokens[6]="1" 
        elif curheader=="16hr.3hrDown": 
            if curvalue=="1": 
                tokens[5]="1" 
        elif curheader=="16hr.CCUp": 
            if curvalue=="1": 
                tokens[6]="1" 
        elif curheader=="16hr.CCDown": 
            if curvalue=="1": 
                tokens[4]="1" 
        elif curheader=="48hr.16hrUp": 
            if curvalue=="1": 
                tokens[7]="1" 
        elif curheader=="48hr.16hrDown": 
            if curvalue=="1": 
                tokens[6]="1" 
        elif curheader=="48hr.3hrUp": 
            if curvalue=="1": 
                tokens[7]="1" 
        elif curheader=="48hr.3hrDown": 
            if curvalue=="1": 
                tokens[5]="1" 
        elif curheader=="48hr.CCUp": 
            if curvalue=="1": 
                tokens[7]="1" 
        elif curheader=="48hr.CCDown": 
            if curvalue=="1": 
                tokens[4]="1" 
        elif curheader=="H1.48hrDown": 
            if curvalue=="1": 
                tokens[7]="1" 
        elif curheader=="H1.16hrDown": 
            if curvalue=="1": 
                tokens[6]="1" 
        elif curheader=="H1.3hrDown": 
            if curvalue=="1": 
                tokens[5]="1" 
        elif curheader=="H1.CCDown": 
            if curvalue=="1": 
                tokens[4]="1" 
    outf.write('\t'.join(tokens)+'\n')
