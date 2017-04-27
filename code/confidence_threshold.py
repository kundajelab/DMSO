low_thresh=0.1
medium_thresh=0.20 

#previous input file 
#peak_entries=open('/srv/scratch/annashch/stemcells/het/anna_all_timepoint_pairs/aggregate_pangwei.adjusted.binarized.filtered.tsv','r').read().split('\n') 
peak_entries=open('diffMatAnna.binarized.combined.new.csv','r').read().split('\n') 
while '' in peak_entries: 
    peak_entries.remove('') 

#confidence-file: 
#confidence=open('/srv/scratch/annashch/stemcells/het/confidenceMatAnna_padjCutoff-0.1_peakCutoff-20.csv','r').read().split('\n') 
confidence=open('confidenceMatAnna.csv','r').read().replace('\"','').split('\n') 
while '' in confidence: 
    confidence.remove('') 


#fold change file so we know if something is upregulated or down-regulated 
#foldchange=open('/srv/scratch/annashch/stemcells/het/foldChangeMatAnna_padjCutoff-0.1_peakCutoff-20.csv','r').read().split('\n') 
foldchange=open('foldChangeMatAnna.csv','r').read().replace('\"','').split('\n') 
while '' in foldchange: 
    foldchange.remove('') 

#map the header of one file to the header of the other file, the naming conventions are different 
header_map=dict() 
header_map={"earlyG1.R1.treated.earlyG1.R1.controlsUp":"earlyG1.R1.treated.earlyG1.R1.controls",
            "earlyG1.R1.treated.earlyG1.R1.controlsDown":"earlyG1.R1.treated.earlyG1.R1.controls",
            "earlyG1.R2.treated.earlyG1.R2.controlsUp":"earlyG1.R2.treated.earlyG1.R2.controls",
            "earlyG1.R2.treated.earlyG1.R2.controlsDown":"earlyG1.R2.treated.earlyG1.R2.controls",
            "lateG1.R1.treated.lateG1.R1.controlsUp":"lateG1.R1.treated.lateG1.R1.controls",
            "lateG1.R1.treated.lateG1.R1.controlsDown":"lateG1.R1.treated.lateG1.R1.controls",
            "lateG1.R2.treated.lateG1.R2.controlsUp":"lateG1.R2.treated.lateG1.R2.controls",
            "lateG1.R2.treated.lateG1.R2.controlsDown":"lateG1.R2.treated.lateG1.R2.controls",
            "SG2M.R1.treated.SG2M.R2.controlsUp":"SG2M.R1.treated.SG2M.R2.controls",
            "SG2M.R1.treated.SG2M.R2.controlsDown":"SG2M.R1.treated.SG2M.R2.controls",
            "SG2M.R2.treated.SG2M.R2.controlsUp":"SG2M.R2.treated.SG2M.R2.controls",
            "SG2M.R2.treated.SG2M.R2.controlsDown":"SG2M.R2.treated.SG2M.R2.controls"}

confidence_dict=dict() 
foldchange_dict=dict() 
confidence_header=('\t'+confidence[0]).split('\t') 
foldchange_header=('\t'+foldchange[0]).split('\t') 
for line in confidence[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[1] 
    startpos=tokens[2] 
    endpos=tokens[3] 
    key=(chrom,startpos,endpos) 
    confidence_dict[key]=dict() 
    for i in range(4,len(confidence_header)): 
        conf_val=float(tokens[i]) 
        confidence_dict[key][confidence_header[i]]=float(conf_val) 
print "built confidence dict" 
for line in foldchange[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[1] 
    startpos=tokens[2] 
    endpos=tokens[3] 
    key=(chrom,startpos,endpos) 
    foldchange_dict[key]=dict() 
    for i in range(4,len(foldchange_header)): 
        foldchange_val=float(tokens[i]) 
        foldchange_dict[key][foldchange_header[i]]=float(foldchange_val) 
print "built fold change dict" 
    

adjusted_dict=dict() 
peak_header=peak_entries[0].split('\t') 
for line in peak_entries[1::]: 
    tokens=line.split('\t') 
    chrom=tokens[0] 
    startpos=tokens[1] 
    endpos=tokens[2] 
    key=(chrom,startpos,endpos) 
    adjusted_dict[key]=dict() 
    for i in range(3,len(peak_header)):
        cur_value=int(tokens[i]) 
        if peak_header[i] not in header_map: 
            #just pass the current value! 
            adjusted_dict[key][peak_header[i]]=cur_value 
        elif cur_value==1: 
            adjusted_dict[key][peak_header[i]]=cur_value 
        else: 
            cur_header=header_map[peak_header[i]]
            corresponding_confidence=confidence_dict[key][cur_header] 
            cur_value=int(tokens[i]) 
            fold_change_value=foldchange_dict[key][cur_header] 
            if corresponding_confidence > medium_thresh: 
                #0! 
                adjusted_dict[key][peak_header[i]]=0 
            elif corresponding_confidence > low_thresh: 
                #-1,if the fold change agrees with the column header 
                if (fold_change_value>0) and (peak_header[i].endswith('Up')): 
                    adjusted_dict[key][peak_header[i]]=-1 
                elif (fold_change_value<0) and (peak_header[i].endswith('Down')): 
                    adjusted_dict[key][peak_header[i]]=-1 
                else: 
                    adjusted_dict[key][peak_header[i]]=0 
            else: 
                #1, if the fold change agrees with the column header 
                if (fold_change_value>0) and (peak_header[i].endswith('Up')): 
                    adjusted_dict[key][peak_header[i]]=1 
                elif (fold_change_value<0) and (peak_header[i].endswith('Down')): 
                    adjusted_dict[key][peak_header[i]]=1 
                else:
                    adjusted_dict[key][peak_header[i]]=0 
#outf=open('thresholded_labels.txt','w')
outf=open('diffMatAnna.binarized.combined.thresholded.new.tsv','w')
outf.write('Chrom\tStartPos\tEndPos\tPeak\t'+'\t'.join(peak_header[3::])+'\n')
peak_id=0 
for entry in adjusted_dict: 
    outf.write('\t'.join(entry)+'\t'+'peak_'+str(peak_id))
    peak_id+=1 
    for task in peak_header[3::]: 
        label=adjusted_dict[entry][task] 
        outf.write('\t'+str(label))
    outf.write('\n') 

        


    
