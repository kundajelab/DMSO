#condense motif hits from the MOODS scanner for comparison against loop lists
import argparse
from os import listdir
import pdb
import pickle

def parse_args():
    parser=argparse.ArgumentParser("condense motif hits from the MOODS scanner for comparison against loop lists")
    parser.add_argument("--motif_hits",nargs="+",help="motif hit directories to parse")
    parser.add_argument("--loop_dir",help="directory containing information about presence of DNA loops")
    parser.add_argument("--motif_name_to_sequence",help="file mapping motif name to the corresponding consensus sequence") 
    parser.add_argument("--outf")
    return parser.parse_args()

def load_loop_directory(loop_dir):
    loop_dict=dict()
    files=listdir(loop_dir)
    for f in files:
        data=open(loop_dir+'/'+f).read().strip().split('\n')
        loop_dict[f]=dict()
        #get the indices of the motif components:
        header=data[0].split('\t')
        print(str(f))
        chr1_index=header.index('chr1') 
        x1_index=header.index('x1')
        x2_index=header.index('x2')
        chr2_index=header.index('chr2')
        y1_index=header.index('y1')
        y2_index=header.index('y2')
        sequence1_index=header.index('sequence_1')
        sequence2_index=header.index('sequence_2')
        #store loop end positions as tuple entries 
        for line in data[1::]:
            tokens=line.split('\t')
            pos1=tuple([tokens[chr1_index],int(tokens[x1_index]),int(tokens[x2_index]),tokens[sequence1_index]])
            pos2=tuple([tokens[chr2_index],int(tokens[y1_index]),int(tokens[y2_index]),tokens[sequence2_index]])
            loop_dict[f][pos1]=pos2
    return loop_dict

#index--> "first"/"second"
#direction--> "pos"/"neg" 
def check_match(loop_matches,category,chrom,startpos,endpos,hit_names,index,direction,loop_dict): 
    #check for a match in the loop dict
    for celltype in loop_dict:
        for first_bin_tuple in loop_dict[celltype]:
            if index=="first":
                bin_chrom=first_bin_tuple[0]
                bin_start=first_bin_tuple[1]
                bin_end=first_bin_tuple[2]
                seq=first_bin_tuple[3]
            else: 
                bin_chrom=loop_dict[celltype][first_bin_tuple][0]
                bin_start=loop_dict[celltype][first_bin_tuple][1]
                bin_end=loop_dict[celltype][first_bin_tuple][2]
                seq=loop_dict[celltype][first_bin_tuple][3]
            #check for a match in the first bin
            chrom=chrom[3::]
            bin_chrom=bin_chrom.replace('chr','') 
            if bin_chrom==chrom:
                if ((startpos >bin_start) and (startpos <bin_end)):
                    if((endpos > bin_start) and (endpos <bin_end)):
                        #we have a hit!
                        keyval=tuple([celltype])+first_bin_tuple+loop_dict[celltype][first_bin_tuple]
                        if keyval not in loop_matches:
                            loop_matches[keyval]=dict()
                        if index not in loop_matches[keyval]:
                            loop_matches[keyval][index]=[]
                        loop_matches[keyval][index].append(tuple([category,direction,chrom,startpos,endpos,hit_names]))
                        break
    #print("done!") 
    return loop_matches 

def parse_hits(loop_matches,hits,loop_dict,category,motif_names,direction):
    c=0
    total=str(len(hits)) 
    for line in hits[1::]:
        c+=1
        if c%1000==0: 
            print(str(c))+"/"+total
        tokens=line.split('\t')
        hit_scores=[float(i) for i in tokens[3::]]
        if max(hit_scores)>0:
            chrom=tokens[0]
            startpos=int(tokens[1])
            endpos=int(tokens[2])
            hit_names=[]
            for i in range(len(hit_scores)):
                if hit_scores[i]>0:
                    hit_names.append(motif_names[i+3])
            loop_matches=check_match(loop_matches,category,chrom,startpos,endpos,hit_names,"first",direction,loop_dict)
            loop_matches=check_match(loop_matches,category,chrom,startpos,endpos,hit_names,"second",direction,loop_dict) 
    return loop_matches

def check_loop_overlap(motif_hits_dir_list,loop_dict):
    #category-->(cell_type,chrom_start,pos_start,seq_start,pos_end,chrom_end,pos_start,pos_end,seq_end)--> {'first'-->[pos/neg,peak,hitnames],'last'-->[pos/neg,peak,hitnames]}
    loop_matches=dict() 
    for dirname in motif_hits_dir_list:
        print(dirname)
        positive_hits=open(dirname+"/motif_hits.txt",'r').read().strip().split('\n')
        negative_hits=open(dirname+"/motif_hits.revcomp.txt",'r').read().strip().split('\n')
        motif_names=positive_hits[0].split('\t')
        category=dirname.split('_')[0]
        print("positive:") 
        loop_matches=parse_hits(loop_matches,positive_hits,loop_dict,category,motif_names,'pos')
        print("negative:")
        loop_matches=parse_hits(loop_matches,negative_hits,loop_dict,category,motif_names,'neg')                
    return loop_matches

def filter_loop_matches(loop_matches):
    filtered_matches=dict()
    for key in loop_matches:
        if (('first' in loop_matches[key]) and ('second' in loop_matches[key])):
            #make sure the motifs are pointing toward each other
            pos=False
            neg=False 
            for entry in loop_matches[key]['first']:
                if entry[1]=="pos":
                    pos=True
            for entry in loop_matches[key]['second']:
                if entry[1]=="neg":
                    neg=True
            if ((pos==True) and (neg==True)):
                #keep!!
                filtered_matches[key]=dict()
                filtered_matches[key]['first']=[]
                filtered_matches[key]['second']=[]
                for entry in loop_matches[key]['first']:
                    if entry[1]=="pos":
                        filtered_matches[key]['first'].append(entry) 
                for entry in loop_matches[key]['second']:
                    if entry[1]=="neg":
                        filtered_matches[key]['second'].append(entry)                 
    return filtered_matches

def write_output_file(outf_prefix,loop_matches,motif_name_to_sequence):
    #dump a pickle!
    pickle.dump(loop_matches,open(outf_prefix+".p","wb"))
    #write a text file
    outf=open(outf_prefix+".tsv",'w')
    for key in loop_matches:
        outf.write('\t'.join([str(i) for i in key]))
        #get consensus sequence for motif hit names; collapse redundant sequences
        for hit in loop_matches[key]['first']:
            motif_names=[motif_name_to_sequence[i] for i in hit[-1]]
            motifs='/'.join(list(set(motif_names)))
            outf.write('\t'+'first'+'\t'+'\t'.join([str(i) for i in hit[:-1]])+'\t'+motifs)
        for hit in loop_matches[key]['second']:
            motif_names=[motif_name_to_sequence[i] for i in hit[-1]]
            motifs='/'.join(list(set(motif_names)))
            outf.write('\t'+'second'+'\t'+'\t'.join([str(i) for i in hit[:-1]])+'\t'+motifs)
        outf.write('\n')

def get_motif_name_to_sequence(fname):
    motif_name_to_sequence=dict()
    data=open(fname,'r').read().strip().split('\n')
    for line in data:
        tokens=line.split('\t')
        motif_name_to_sequence[tokens[0]]=tokens[1]
    return motif_name_to_sequence

        
def main():
    args=parse_args()
    print("getting map of motif names to sequences")
    motif_name_to_sequence=get_motif_name_to_sequence(args.motif_name_to_sequence) 
    print("loading loop directory")
    loop_dict=load_loop_directory(args.loop_dir)
    print("checking for motifs at the loop boundaries") 
    loop_matches=check_loop_overlap(args.motif_hits,loop_dict)
    #loop_matches=pickle.load(open("consensus_summary.p",'rb'))
    loop_matches=filter_loop_matches(loop_matches) 
    print("writing output file")
    write_output_file(args.outf,loop_matches,motif_name_to_sequence) 
    
if __name__=="__main__":
    main() 
