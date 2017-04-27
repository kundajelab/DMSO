#Embedded file name: /srv/scratch/annashch/deeplearning/utils/fastaFromBed.py
import sys
import pysam
import random
from Params import * 
from generateSplits import * 
import pdb 
def make_fasta(bedfile, reffile, outfasta_name, line_length,sample=False):
    peak_names = dict()
    bedinput = open(bedfile, 'r').read().split('\n')
    print 'Read in BED coordinates'
    while '' in bedinput:
        bedinput.remove('')
    #if the "sample" argument is given, sample a subset of the peaks (mostly used for downsizing a dataset for model debugging purposes
    #MAKE SURE ALL PEAKS IN OUR TARGET REGION GET INCLUDED!!!! 
    if sample !=False: 
        total=len(bedinput) 
        desired=sample 
        downsample_factor=desired*1.0/total 
        print "downsampling by: "+str(downsample_factor) 
    #add in pluripotency regions! 
    pluripotency_dict = make_pluripotency_dict(pluripotency_region_file, pluripotent_region_flank)
    outfasta = open(outfasta_name, 'w')
    ref_source = pysam.FastaFile(reffile)
    counter = 0
    total = str(len(bedinput))
    for line in bedinput[1::]:
        if line.startswith('Chrom'): 
            continue 
        counter += 1
        if counter % 10000 == 0:
            print str(counter) + '/' + total
        tokens = line.split('\t')
        chrom = tokens[0]
        #if chrom.count('_')>0: 
        #    continue 
        pos_start = int(tokens[1])
        pos_end = int(tokens[2]) 
        if sample!=False: 
            inpluripotency_region=isPeakInPluripotencyRegion(pluripotency_dict,chrom,int(pos_start),int(pos_end)) 
            if not inpluripotency_region: 
                prob=random.random() 
                if prob > downsample_factor: 
                    continue 
        peak_length=pos_end-pos_start+1
        toadd=line_length-peak_length 
        flank=toadd/2
        peak_name = tokens[3]
        #print "toadd:"+str(toadd) 
        #print "flank:"+str(flank) 
        #print "peak_name:"+str(peak_name) 

        #pdb.set_trace() 
        #if flank < 0 (i.e. peak is too wide) split into multiple peaks! 
        if flank>=0:
            #print "flank > 0" 
            pos_start=pos_start-flank-1 
            if toadd%2==1:
                pos_end=pos_end+flank+1
            else: 
                pos_end=pos_end+flank 
            if pos_start < 1:
                pos_start =1
                pos_end =line_length+1 
            header = '>' + peak_name
            seq = ref_source.fetch(chrom, pos_start, pos_end)
            if seq=="":
                print str(line) 
                continue
            else: 
                peak_names[peak_name] = [chrom, pos_start, pos_end]
                outfasta.write(header + '\n' + seq + '\n')
        else: 
            #print "flank is not greater than 0" 
            temp_start=pos_start 
            temp_end=temp_start+line_length
            split_index=0 
            while True: 
                temp_peak_name=peak_name+"_"+str(split_index) 
                header=">"+temp_peak_name 
                seq = ref_source.fetch(chrom, temp_start,temp_end)
                if seq=="":
                    print str(line) 
                else: 
                    peak_names[temp_peak_name] = [chrom, temp_start, temp_end]
                    outfasta.write(header + '\n' + seq + '\n')
                if temp_end>=pos_end: 
                    break 
                else: 
                    temp_start=temp_end+1 
                    temp_end=temp_start+line_length
                    split_index+=1 
       # pdb.set_trace() 
    return peak_names
