import argparse
import pdb
def parse_args():
    parser=argparse.ArgumentParser(description="Add in motif scanning MOODS information")
    parser.add_argument("--predicted_score")
    parser.add_argument("--motif_hits")
    parser.add_argument("--topn",type=int,default=5)
    parser.add_argument("--outf")
    return parser.parse_args()

def filter_motif_hits(motif_hits,topn):
    all_hits=dict()
    filtered_hits=dict()
    header=motif_hits[0].split('\t')
    header=[i.split('/')[-1] for i in header]
    motif_names=header[3::]
    for entry in motif_hits[1::]:
        tokens=entry.split('\t')
        chrom=tokens[0]
        startpos=tokens[1]
        endpos=tokens[2]
        peak_entry='_'.join([chrom,startpos,endpos])
        values=[float(i) for i in tokens[3::]]
        filtered_hits[peak_entry]=dict() 
        all_hits[peak_entry]=dict() 
        for motif_index in range(len(motif_names)):
            motif_score=values[motif_index]
            motif_name=motif_names[motif_index]
            if motif_score !=0:
                if motif_score not in all_hits[peak_entry]:
                    all_hits[peak_entry][motif_score]=[motif_name]
                else:
                    all_hits[peak_entry][motif_score].append(motif_name)
        #get the top n scores
        score_keys=all_hits[peak_entry].keys()
        score_keys.sort(reverse=True)
        for i in range(min([topn,len(score_keys)])):
            try:
                filtered_hits[peak_entry][score_keys[i]]=all_hits[peak_entry][score_keys[i]]
            except:
                pdb.set_trace()
    print(str(filtered_hits))
    return filtered_hits 

def main():
    args=parse_args()
    motif_hits=open(args.motif_hits,'r').read().strip().split('\n')
    filtered_motif_hits=filter_motif_hits(motif_hits,args.topn)
    predicted_score=open(args.predicted_score,'r').read().strip().split('\n')
    predicted_score_peak_to_entry=dict()
    for line in predicted_score[1::]:
        tokens=line.split('\t')
        gene=tokens[0]
        peak=tokens[1]
        score=str(round(float(tokens[2]),2))
        
        predicted_score_peak_to_entry[peak]=[gene,peak,score]
    outf=open(args.outf,'w')
    outf.write('Gene\tPeak\tScore\t'+'\t'.join(['Motif_Score'+str(i)+'\t'+"Motif"+str(i) for i in range(args.topn)])+'\n')
    for peak in predicted_score_peak_to_entry:
        motif_hits_cur_peak=filtered_motif_hits[peak]
        outf.write('\t'.join(predicted_score_peak_to_entry[peak]))
        keys=motif_hits_cur_peak.keys()
        keys.sort(reverse=True)
        for score_to_motif in keys:
            outf.write('\t'+str(round(score_to_motif,2))+'\t'+','.join(motif_hits_cur_peak[score_to_motif]))
        outf.write('\n')
        

if __name__=="__main__":
    main()
    
    
