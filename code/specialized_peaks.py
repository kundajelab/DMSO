#gets 3hr, 16hr, 48hr peaks that are upregulated > fibroblast, 
#case 1) these are also upregulated in H1
#case 2) don't enforce them to be upregulated in H1 
data=open('diffMatAnna.binarized.combined.stringent.csv','r').read().strip().split('\n') 
outf=open('specialized_peaks.csv','w')  
header=data[0].split('\t') 

x3hr=[] 
x16hr=[] 
x48hr=[] 

index_to_label=dict() 
for i in range(len(header)): 
    index_to_label[i]=header[i] 
label_to_index=dict() 
for key in index_to_label: 
    val=index_to_label[key] 
    label_to_index[val]=key 

for line in data[1::]: 
    tokens=line.split('\t') 
    outputline=tokens[0:3] 
    #check 3hr 
    x3hrval=int(tokens[label_to_index['3hr']])
    x16hrval=int(tokens[label_to_index['16hr']]) 
    x48hrval=int(tokens[label_to_index['48hr']] ) 
    #check t0 
    cc=int(tokens[label_to_index['CC']])
    hk=int(tokens[label_to_index['Hk']])
    m5=int(tokens[label_to_index['M5']])
    h1=int(tokens[label_to_index['H1']])

    #check for upregulation at 3hrs 
    x3hr_up_cc=int(tokens[label_to_index['X3hr.CCUp']]) 
    x3hr_up_m5=int(tokens[label_to_index['X3hr.M5Up']])
    x3hr_up_hk=int(tokens[label_to_index['X3hr.HkUp']]) 
    #check for downregulation at 3hrs 
    x3hr_down_cc=int(tokens[label_to_index['X3hr.CCDown']])
    x3hr_down_m5=int(tokens[label_to_index['X3hr.M5Down']])
    x3hr_down_hk=int(tokens[label_to_index['X3hr.HkDown']])
    
    #four tasks to consider
    cc_3hr_up=int(x3hrval and (cc==0 or x3hr_up_cc==1))
    hk_3hr_up=int(x3hrval and (hk==0 or x3hr_up_hk==1))
    m5_3hr_up=int(x3hrval and (m5==0 or x3hr_up_m5==1))
    task_3hr_up=int(cc_3hr_up and hk_3hr_up and m5_3hr_up) 

    cc_3hr_down=int((not x3hrval) and (cc==1 or x3hr_down_cc==1))
    hk_3hr_down=int((not x3hrval) and (hk==1 or x3hr_down_hk==1))
    m5_3hr_down=int((not x3hrval) and (m5==1 or x3hr_down_m5==1))
    task_3hr_down=int(cc_3hr_down and hk_3hr_down and m5_3hr_down)

    #plus h1 
    task_3hr_up_h1=int(task_3hr_up and h1)
    task_3hr_down_h1=int(task_3hr_down and (not h1)) 
    
    ##############################################################

    #check for upregulation at 3hrs 
    x16hr_up_cc=int(tokens[label_to_index['X16hr.CCUp']]) 
    x16hr_up_m5=int(tokens[label_to_index['X16hr.M5Up']])
    x16hr_up_hk=int(tokens[label_to_index['X16hr.HkUp']]) 
    #check for downregulation at 16hrs 
    x16hr_down_cc=int(tokens[label_to_index['X16hr.CCDown']])
    x16hr_down_m5=int(tokens[label_to_index['X16hr.M5Down']])
    x16hr_down_hk=int(tokens[label_to_index['X16hr.HkDown']])
    
    #four tasks to consider
    cc_16hr_up=int(x16hrval and (cc==0 or x16hr_up_cc==1))
    hk_16hr_up=int(x16hrval and (hk==0 or x16hr_up_hk==1))
    m5_16hr_up=int(x16hrval and (m5==0 or x16hr_up_m5==1))
    task_16hr_up=int(cc_16hr_up and hk_16hr_up and m5_16hr_up)

    cc_16hr_down=int((not x16hrval) and (cc==1 or x16hr_down_cc==1))
    hk_16hr_down=int((not x16hrval) and (hk==1 or x16hr_down_hk==1))
    m5_16hr_down=int((not x16hrval) and (m5==1 or x16hr_down_m5==1))
    task_16hr_down=int(cc_16hr_down and hk_16hr_down and m5_16hr_down)

    #plus h1 
    task_16hr_up_h1=int(task_3hr_up and h1)
    task_16hr_down_h1=int(task_16hr_down and (not h1))

    ###########################################################
    #check for upregulation at 3hrs 
    x48hr_up_cc=int(tokens[label_to_index['X48hr.CCUp']]) 
    x48hr_up_m5=int(tokens[label_to_index['X48hr.M5Up']])
    x48hr_up_hk=int(tokens[label_to_index['X48hr.HkUp']]) 
    #check for downregulation at 48hrs 
    x48hr_down_cc=int(tokens[label_to_index['X48hr.CCDown']])
    x48hr_down_m5=int(tokens[label_to_index['X48hr.M5Down']])
    x48hr_down_hk=int(tokens[label_to_index['X48hr.HkDown']])
    
    #four tasks to consider
    cc_48hr_up=int(x48hrval and (cc==0 or x48hr_up_cc==1))
    hk_48hr_up=int(x48hrval and (hk==0 or x48hr_up_hk==1))
    m5_48hr_up=int(x48hrval and (m5==0 or x48hr_up_m5==1))
    task_48hr_up=int(cc_48hr_up and hk_48hr_up and m5_48hr_up)

    cc_48hr_down=int((not x48hrval) and (cc==1 or x48hr_down_cc==1))
    hk_48hr_down=int((not x48hrval) and (hk==1 or x48hr_down_hk==1))
    m5_48hr_down=int((not x48hrval) and (m5==1 or x48hr_down_m5==1)) 
    task_48hr_down=int(cc_48hr_down and hk_48hr_down and m5_48hr_down)

    #plus h1 
    task_48hr_up_h1=int(task_3hr_up and h1)
    task_48hr_down_h1=int(task_48hr_down and (not h1))

    outputline.append(task_3hr_up)
    outputline.append(task_3hr_down) 
    outputline.append(task_3hr_up_h1) 
    outputline.append(task_3hr_down_h1) 
    outputline.append(task_16hr_up) 
    outputline.append(task_16hr_down) 
    outputline.append(task_16hr_up_h1) 
    outputline.append(task_16hr_down_h1) 
    outputline.append(task_48hr_up) 
    outputline.append(task_48hr_down) 
    outputline.append(task_48hr_up_h1) 
    outputline.append(task_48hr_down_h1) 
    
    outputline='\t'.join([str(i) for i in outputline])+'\n'
    outf.write(outputline) 
    
