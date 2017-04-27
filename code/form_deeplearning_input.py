from os import listdir
from os.path import isfile, join
import subprocess 
import numpy as np 
import random
from fastaFromBed import * 
from generateSplits import * 
import pdb 
#Threshold peak files for individual replicates using IDR 
#combine individual replicates through a majority vote 
from Params import * 

        
def generate_data_windows(): 
    #source=open("thresholded_labels.txt",'r').read().split('\n') 
    #source=open(output_data_dir+"aggregate_pangwei.adjusted.binarized.filtered.tsv",'r').read().split('\n') 
    #source=open(output_data_dir+"aggregate_results.tsv",'r').read().split('\n')
    #source=open('diffMatAnna.binarized.combined.thresholded.tsv','r').read().split('\n') 
    #source=open('diffMatAnna.binarized.combined.thresholded.new.tsv','r').read().split('\n')
    #source=open('figure.tsv','r').read().split('\n')
    source=open('diffMat_multifactor.binarized.combined.tsv','r').read().split('\n') 
    while '' in source: 
        source.remove('') 
    #outf=open(output_data_dir+"aggregate_results.SLICED.tsv",'w') 
    #outf=open(output_data_dir+"aggregate_pangwei.SLICED.tsv",'w') 
    #outf=open("thresholded_labels.SLICED.txt",'w') 
    #outf=open("diffMatAnna.binarized.combined.thresholded.SLICED.tsv",'w') 
    #outf=open("diffMatAnna.binarized.combined.thresholded.stringent.SLICED.tsv",'w')
    outf=open('dmso2.SLICED.tsv','w') 
    #outf.write("Chrom\tStart\tEnd\tPeakName\tCC\t3hr\t16hr\t48hr\tH1\t3hr-CC\t16hr-3hr\t48hr-16hr\tH1-48hr\n")
    outf.write(source[0]+'\n') 
    counter=0 
    for line in source[1::]: 
        tokens=line.split('\t') 
        peak_end=int(tokens[2])
        peak_start=max([1,peak_end - windowSize])#int(tokens[1])
        start_boundary=int(tokens[1])
        window_start=peak_start
        #get a left-flank of all 0s to serve as a negative 
        left_flank_start=peak_start-windowSize
        left_flank_end=left_flank_start=peak_start 
        #make the bin that's centered at peak summit! 
        summit=int(start_boundary+(peak_end-start_boundary)*0.5)
        centered_start=max([1,int(summit-0.5*windowSize)])
        centered_end=centered_start+windowSize 
        counter+=1
        outf.write(tokens[0]+'\t'+str(centered_start)+'\t'+str(centered_end)+'\t'+"centered_"+str(counter)+'\t'+'\t'.join(tokens[3::])+'\n')
        while window_start < start_boundary: 
            counter+=1 
            window_end=window_start+windowSize
            #window_end=peak_end 
            outf.write(tokens[0]+'\t'+str(window_start)+'\t'+str(window_end)+'\t'+"augmented_"+str(counter)+'\t'+'\t'.join(tokens[3::])+'\n')
            jitter_size=0 
            #will we have jitter? 
            jitter_presence=random.random()
            if jitter_presence < jitterProb: 
                #how much? 
                jitter_size =random.randint(-1*jitterMax,jitterMax) 
            window_start=window_start+windowOverlap+jitter_size 
            #window_start=peak_end 
        #get a right-flank of all zeros to serve as a negative! 
        right_flank_start=window_start 
        right_flank_end=window_start+windowSize 
        #populate the negative flanking regions
        numzeros=len(tokens[3::])
        counter+=1
        outf.write(tokens[0]+'\t'+str(left_flank_start)+'\t'+str(left_flank_end)+'\t'+"negative_"+str(counter)+'\t'+'\t'.join(["0"]*numzeros)+'\n')
        counter+=1
        outf.write(tokens[0]+'\t'+str(right_flank_start)+'\t'+str(right_flank_end)+'\t'+"negative_"+str(counter)+'\t'+'\t'.join(["0"]*numzeros)+'\n')

def make_labels(peak_dict): 
    #source=open(output_data_dir+"aggregate_results.SLICED.tsv",'r').read().split('\n') 
    #source=open(output_data_dir+"aggregate_pangwei.SLICED.tsv",'r').read().split('\n') 
    #source=open("thresholded_labels.txt",'r').read().split('\n') 
    #source=open("thresholded_labels.SLICED.txt",'r').read().split('\n') 
    #source=open("diffMatAnna.binarized.combined.thresholded.SLICED.tsv",'r').read().split('\n') 
    #source=open("diffMatAnna.binarized.combined.stringent.thresholded.SLICED.tsv",'r').read().split('\n') 
    #source=open("regression.csv",'r').read().split('\n') 
    #source=open('debug.deeplift.input.tsv','r').read().split('\n')  
    source=open('dmso2.SLICED.tsv','r').read().split('\n')  
    header=source[0].split('\t')[3::] 
    source_dict=dict()
    while '' in source: 
        source.remove('') 
    outf=open(out_labels,'w') 
    outf.write('\t'.join(header)+'\n') 
    for line in source[1::]: 
        tokens=line.split('\t')[3::]
        peak_name=tokens[0] 
        peak_vals=tokens[1::] 
        source_dict[peak_name]=peak_vals 
    for peak in peak_dict: 
        peaksubset=peak
        if peak.count('_')>1: 
            peaksubset='_'.join(peak.split('_')[0:2]) 
        '''
        elif peak.count('_')==1: 
            peaksubset=peak.split('_')[0] 
        else:
            peaksubset=peak 
        if peaksubset in source_dict: 
        '''
        if peaksubset in source_dict: 
            outf.write(peak+'\t'+'\t'.join(source_dict[peaksubset])+'\n')
        else: 
            pdb.set_trace() 
            
def make_peak_dict(): 
    #source=open(output_data_dir+"aggregate_results.SLICED.tsv",'r').read().split('\n') 
    #source=open(output_data_dir+"aggregate_pangwei.SLICED.tsv",'r').read().split('\n') 
    #source=open("thresholded_labels.SLICED.txt",'r').read().split('\n') 
    #source=open("diffMatAnna.binarized.combined.thresholded.SLICED.tsv",'r').read().split('\n')     
    #source=open("diffMatAnna.binarized.combined.stringent.thresholded.SLICED.tsv",'r').read().split('\n')  
    #source=open("debug.deeplift.input.tsv",'r').read().split('\n')  
    source=open("dmso2.SLICED.tsv",'r').read().split('\n')  
    while '' in source: 
        source.remove('') 
    peak_dict=dict() 
    for line in source[1::]: 
        tokens=line.split('\t')
        peak_name=tokens[3] 
        entry=tokens[0:3] 
        peak_dict[peak_name]=entry 
    return peak_dict


    
        
def main(): 
    
    generate_data_windows() 
    #peak_dict=make_fasta(output_data_dir+"aggregate_pangwei.SLICED.tsv",refseq,out_fasta,line_length,500000) 
    #peak_dict=make_fasta("thresholded_labels.SLICED.txt",refseq,out_fasta,line_length,500000) 
    #peak_dict=make_fasta("diffMatAnna.binarized.combined.thresholded.SLICED.tsv",refseq,out_fasta,line_length,500000) 
    #peak_dict=make_fasta("debug.deeplift.input.tsv",refseq,out_fasta,line_length) 
    peak_dict=make_fasta("dmso2.SLICED.tsv",refseq,out_fasta,line_length,500000)#,800000) 
    make_labels(peak_dict) 
    make_splits(peak_dict,test_chroms,validation_chroms,pluripotency_region_file,pluripotent_region_flank,out_splits_train,out_splits_test,out_splits_validate)

if __name__=="__main__": 
    main() 
