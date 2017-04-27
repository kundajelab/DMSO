data=open('diffMat_multifactor.csv','r').read().replace('\"','').split('\n') 
while '' in data: 
    data.remove('') 
outf=open('diffMat_multifactor.binarized.csv','w') 
header=data[0].split('\t') #extra tab in front to handle R output  
same_header='\t'.join(header[0:3])
diff_header=header[3::] 
print str(diff_header) 
diff_header_paired='' 
for entry in diff_header: 
    diff_header_paired=diff_header_paired+'\t'+entry+'Up\t'+entry+'Down' 
outf.write(same_header+diff_header_paired+'\n') 
for line in data[1::]: 
    tokens=line.split('\t') 
    outstring='\t'.join(tokens[1:4])
    for i in range(4,len(tokens)): 
        if tokens[i]=="0": 
            outstring=outstring+'\t0\t0'
        elif float(tokens[i]) <  0:
            outstring=outstring+'\t0\t1' 
        elif float(tokens[i]) >0: 
            outstring=outstring+'\t1\t0'
    outf.write(outstring+'\n') 
