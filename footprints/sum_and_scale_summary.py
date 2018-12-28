import pdb 
data=open("summary.txt",'r').read().strip().split('\n')
outf=open("summary.pos.neg.sum.txt",'w')
summary=dict()
scales=dict()
scales['earlyG1.controls']=71689147/9844916
scales['earlyG1.dmso']=71689147/10486427
scales['lateG1.controls']=71689147/12609675
scales['lateG1.dmso']=71689147/14115913
scales['SG2M.controls']=71689147/13546943
scales['SG2M.dmso']=71689147/11085273
 

fields=data[0].split('\t')
fields_set=set([]) 
for line in data[1::]:
    tokens=line.split('\t')
    cur_pos=tokens[0]
    for i in range(1,len(tokens)):
        cur_field='.'.join(fields[i].split('.')[0:3])
        fields_set.add(cur_field) 
        cur_group='.'.join(fields[i].split('.')[0:2])
        cur_scale_factor=scales[cur_group]
        cur_val=float(tokens[i])#*cur_scale_factor
        if cur_pos not in summary:
            summary[cur_pos]=dict()
        if cur_field not in summary[cur_pos]:
            summary[cur_pos][cur_field]=float(cur_val)
        else:
            summary[cur_pos][cur_field]+=float(cur_val)

header_fields=list(fields_set)
outf.write('Pos'+'\t'+'\t'.join(header_fields)+'\n')
for cur_pos in summary:
    outf.write(cur_pos)
    for field in header_fields: 
        outf.write('\t'+str(summary[cur_pos][field]))
    outf.write('\n')
    
