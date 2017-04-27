from os import listdir 
from os.path import isfile, join
import math 

#assigns confidence values for all peaks to use as inputs. 
peak_file=open('aggregate_pangwei.SLICED.tsv','r').read().split('\n') 
while '' in peak_file: 
    peak_file.remove('') 
binsize=10000 
pos_dict=dict() 
for line in peak_file[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    start_pos=int(tokens[1]) 
    end_pos=int(tokens[2]) 
    peak_name=tokens[3] 
    if chrom not in pos_dict: 
        pos_dict[chrom]=dict() 
    curbin=start_pos/binsize 
    if curbin not in pos_dict[chrom]: 
        pos_dict[chrom][curbin]=dict() 
    pos_dict[chrom][curbin][start_pos]=dict() 
    pos_dict[chrom][curbin][start_pos]['endpos']=end_pos
    pos_dict[chrom][curbin][start_pos]['peakname']=peak_name 
    #dictionary task-> list of confidence values 
    pos_dict[chrom][curbin][start_pos]['cc']=[]
    pos_dict[chrom][curbin][start_pos]['3hr']=[]
    pos_dict[chrom][curbin][start_pos]['16hr']=[]
    pos_dict[chrom][curbin][start_pos]['48hr']=[]
    
print "built dictionary of peak positions!" 
#peaks 
basedir="/srv/scratch/pangwei/het/output/"
#cc dirs 

cc_dirs=['10-CC_rep2','9-CC_rep1'] 
hr3_dirs=['4-3hr_rep1','6-3hr_rep3','5-3hr_rep2']
hr16_dirs=['1-16hr_rep1','2-16hr_rep2','3-16hr_rep3'] 
hr48_dirs=['21-48hr_rep1','7-48hr_rep2','8-48hr_rep3'] 
#for cc 
for dirname in cc_dirs: 
    mypath=basedir+dirname 
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    for f in onlyfiles:
        if f.endswith('.xls'): 
            data=open(mypath+'/'+f,'r').read().split('\n') 
            while '' in data: 
                data.remove('') 
            for line in data: 
                if line.startswith('#'): 
                    continue 
                tokens=line.split('\t') 
                try:
                    confidence=float(tokens[6]) 
                except: 
                    continue 
                chrom=tokens[0] 
                startpos= int(tokens[1])
                endpos=int(tokens[2]) 
                curbin=startpos/binsize 
                if chrom in pos_dict: 
                    foundpeak=False 
                    for b in [curbin-1,curbin,curbin+1]: 
                        if b in pos_dict[chrom]: 
                            for target_start_pos in pos_dict[chrom][b]: 
                                #print "checking startpos:"+str(startpos) +";endpos:"+str(endpos) +" against:"+str(target_start_pos)
                                target_end_pos=pos_dict[chrom][b][target_start_pos]['endpos'] 
                                if (startpos>=target_start_pos) and (startpos <=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['cc'].append(confidence) 
                                    foundpeak=True 
                                    #print "found!" 
                                    #break 
                                elif (endpos>=target_start_pos) and (endpos <=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['cc'].append(confidence) 
                                    foundpeak=True 
                                    #print "found!" 
                                    #break 
                                elif (target_start_pos>=startpos) and (target_end_pos <=endpos): 
                                    pos_dict[chrom][b][target_start_pos]['cc'].append(confidence) 
                                    foundpeak=True 
                                elif (abs(target_end_pos-endpos)<200) or (abs(target_start_pos-startpos)<200): 
                                    pos_dict[chrom][b][target_start_pos]['cc'].append(confidence) 
                                    foundpeak=True 

print "CC confidence values populated" 
#for 3hr 
for dirname in hr3_dirs: 
    mypath=basedir+dirname 
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    for f in onlyfiles:
        if f.endswith('.xls'): 
            data=open(mypath+'/'+f,'r').read().split('\n') 
            while '' in data: 
                data.remove('') 
            for line in data: 
                if line.startswith('#'): 
                    continue 
                tokens=line.split('\t') 
                try:
                    confidence=float(tokens[6]) 
                except:
                    continue 
                chrom=tokens[0] 
                startpos= int(tokens[1])
                endpos=int(tokens[2]) 
                curbin=startpos/binsize 
                if chrom in pos_dict: 
                    foundpeak=False 
                    for b in [curbin-1,curbin,curbin+1]: 
                        #if foundpeak==True: 
                        #    break 
                        if b in pos_dict[chrom]: 
                            for target_start_pos in pos_dict[chrom][b]: 
                                target_end_pos=pos_dict[chrom][b][target_start_pos]['endpos'] 
                                if (startpos>=target_start_pos) and (startpos<=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['3hr'].append(confidence) 
                                    foundpeak=True 
                                    #break 
                                elif (endpos>=target_start_pos) and (endpos<=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['3hr'].append(confidence) 
                                    foundpeak=True 
                                    #break 
                                elif (target_start_pos>=startpos) and (target_end_pos <=endpos): 
                                    pos_dict[chrom][b][target_start_pos]['3hr'].append(confidence) 
                                elif (abs(target_start_pos - startpos)<200) or (abs(target_end_pos-endpos)<200): 
                                    pos_dict[chrom][b][target_start_pos]['3hr'].append(confidence) 
print "3hr confidence values populated" 

#for 16hr 
for dirname in hr16_dirs: 
    mypath=basedir+dirname 
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    for f in onlyfiles:
        if f.endswith('.xls'): 
            data=open(mypath+'/'+f,'r').read().split('\n') 
            while '' in data: 
                data.remove('') 
            for line in data: 
                if line.startswith('#'): 
                    continue 
                tokens=line.split('\t') 
                try:
                    confidence=float(tokens[6]) 
                except:
                    continue 
                chrom=tokens[0] 
                startpos= int(tokens[1])
                endpos=int(tokens[2]) 
                curbin=startpos/binsize 
                if chrom in pos_dict: 
                    foundpeak=False 
                    for b in [curbin-1,curbin,curbin+1]: 
                        #if foundpeak==True: 
                        #    break 
                        if b in pos_dict[chrom]: 
                            for target_start_pos in pos_dict[chrom][b]: 
                                target_end_pos=pos_dict[chrom][b][target_start_pos]['endpos'] 
                                if (startpos>=target_start_pos) and (startpos <=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['16hr'].append(confidence) 
                                    foundpeak=True 
                                    #break 
                                elif (endpos>=target_start_pos) and (endpos <=target_end_pos):
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['16hr'].append(confidence) 
                                    foundpeak=True 
                                    #break 
                                elif (target_start_pos>=startpos) and (target_end_pos <=endpos): 
                                    pos_dict[chrom][b][target_start_pos]['16hr'].append(confidence) 
                                elif (abs(target_start_pos - startpos)<200) or (abs(target_end_pos-endpos)<200): 
                                    pos_dict[chrom][b][target_start_pos]['16rr'].append(confidence) 

print "16hr confidence values populated" 
#for 48hr 
for dirname in hr48_dirs: 
    mypath=basedir+dirname 
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    for f in onlyfiles:
        if f.endswith('.xls'): 
            data=open(mypath+'/'+f,'r').read().split('\n') 
            while '' in data: 
                data.remove('') 
            for line in data: 
                if line.startswith('#'): 
                    continue 
                tokens=line.split('\t') 
                try: 
                    confidence=float(tokens[6]) 
                except: 
                    continue                
                chrom=tokens[0] 
                startpos= int(tokens[1])
                endpos=int(tokens[2])
                curbin=startpos/binsize 
                if chrom in pos_dict: 
                    foundpeak=False 
                    for b in [curbin-1,curbin,curbin+1]: 
                        #if foundpeak==True: 
                        #    break 
                        if b in pos_dict[chrom]: 
                            for target_start_pos in pos_dict[chrom][b]: 
                                target_end_pos=pos_dict[chrom][b][target_start_pos]['endpos'] 
                                if (startpos>=target_start_pos) and (startpos <=target_end_pos):
                                    foundpeak=True 
                                    #our peak is within the limits of the merged target peak! 
                                    pos_dict[chrom][b][target_start_pos]['48hr'].append(confidence) 
                                    #break 
                                elif (endpos>=target_start_pos) and (endpos <=target_end_pos): 
                                    foundpeak=True 
                                    #close to the beginning of target peak, might not fit exactly due to jitter 
                                    pos_dict[chrom][b][target_start_pos]['48hr'].append(confidence) 
                                    #break 
                                elif (target_start_pos>=startpos) and (target_end_pos <=endpos): 
                                    pos_dict[chrom][b][target_start_pos]['48hr'].append(confidence) 
                                elif (abs(target_start_pos - startpos)<200) or (abs(target_end_pos-endpos)<200): 
                                    pos_dict[chrom][b][target_start_pos]['48hr'].append(confidence) 
print "48hr confidence values populated" 
#differential expression matrix from DESeq2 
confmat=open('/srv/scratch/annashch/stemcells/het/confidenceMatAnna_padjCutoff-0.1_peakCutoff-20.csv','r').read().split('\n') 
while '' in confmat: 
    confmat.remove('') 
header=confmat[0].split('\t') 
#index 4& up --> tasks 
significant_thresh=0.1
for line in confmat[1::]: 
    tokens=line.split('\t') 
    #token 0 is the index from R, skip it 
    chrom=tokens[1] 
    startpos=int(tokens[2]) 
    endpos=int(tokens[3]) 
    curbin=startpos/binsize 
    foundpeak=False 
    foundbin=None 
    found_target_start_pos=None 
    if (chrom in pos_dict): 
        for b in [curbin-1,curbin,curbin+1]: 
            if b in pos_dict[chrom]: 
                #figure out which peak to account for here 
                for target_start_pos in pos_dict[chrom][b]: 
                    target_end_pos=pos_dict[chrom][b][target_start_pos]['endpos'] 
                    if (startpos>=target_start_pos) and (startpos <=target_end_pos):
                        foundpeak=True 
                        foundbin=b
                        found_target_start_pos=target_start_pos 
                        #break 
                    elif (endpos>=target_start_pos) and (endpos <=target_end_pos): 
                        foundpeak=True 
                        foundbin=b 
                        found_target_start_pos=target_start_pos 
                        #break 
                    elif (target_start_pos>=startpos) and (target_end_pos <=endpos): 
                        foundpeak=True 
                        foundbin=b 
                        found_target_start_pos=target_start_pos                         
                    elif (abs(target_start_pos - startpos)<200) or (abs(target_end_pos-endpos)<200): 
                        foundpeak=True 
                        foundbin=b 
                        found_target_start_pos=target_start_pos                         
                        
    if foundpeak==False: 
        continue 
    for i in range(4,len(tokens)): 
        task=header[i] 
        value=float(tokens[i])
        if value < significant_thresh: 
            value=-10*math.log(value)
            #add to the pos_dict for the specific task! 
            if task not in pos_dict[chrom][foundbin][found_target_start_pos]: 
                pos_dict[chrom][foundbin][found_target_start_pos][task]=[value] 
            else: 
                pos_dict[chrom][foundbin][found_target_start_pos][task].append(value) 
print "differential expression confidence values populated" 
#write output file peak-name to confidence score 
alltasks=['cc','3hr','16hr','48hr']+header[4::]
outf_max=open('confidence_max.txt','w') 
outf_max.write('Peak\tConfidence\n')
outf_average=open('confidence_average.txt','w') 
outf_average.write('Peak\tConfidence\n') 
#print str(pos_dict) 
for chrom in pos_dict: 
    for curbin in pos_dict[chrom]: 
        for startpos in pos_dict[chrom][curbin]: 
            peakname=pos_dict[chrom][curbin][startpos]['peakname'] 
            conf_vals_all=[] 
            for task in alltasks: 
                if task in pos_dict[chrom][curbin][startpos]: 
                    cur_task_vals=pos_dict[chrom][curbin][startpos][task] 
                    conf_vals_all=conf_vals_all+cur_task_vals
            #get the maximum 
            if len(conf_vals_all)==0: 
                print peakname 
                continue 
            maxconf=max(conf_vals_all) 
            #get the average 
            average_conf=(1.0*sum(conf_vals_all))/len(conf_vals_all)
            outf_max.write(peakname+'\t'+str(maxconf)+'\n') 
            outf_average.write(peakname+'\t'+str(average_conf)+'\n') 

            
    

