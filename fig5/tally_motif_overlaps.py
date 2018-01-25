data=open("motifs.txt",'r').read().strip().split('\n')
region_tally=dict()
motifs=set([])
for line in data:
    tokens=line.split('\t')
    peak_name=tokens[3]
    if peak_name not in region_tally:
        region_tally[peak_name]=dict()
    #make sure the motif is more than 100 bases away from the edge of the region, fully contained in the region
    motif_start=int(tokens[5])
    motif_end=int(tokens[6])
    region_start=int(tokens[1])
    region_end=int(tokens[2])
    if ((region_end-100) < motif_end):
        continue
    if ((region_start+100)>motif_start):
        continue
    motif_fam=tokens[7].split('_')[0]
    motifs.add(motif_fam)
    if motif_fam not in region_tally[peak_name]:
        region_tally[peak_name][motif_fam]=1
    else:
        region_tally[peak_name][motif_fam]+=1
outf=open('motif_tally.txt','w')
for peak_name in region_tally:
    for motif_fam in region_tally[peak_name]:
        outf.write(peak_name+'\t'+motif_fam+'\t'+str(region_tally[peak_name][motif_fam])+'\n')

#get summary matrix
motifs=list(motifs)
outf=open("motif_summary_matrix.txt",'w')
outf.write("Peak\t"+'\t'.join(motifs)+'\n')
for peak in region_tally:
    outf.write(peak)
    for motif in motifs:
        if motif in region_tally[peak]:
            outf.write('\t'+str(region_tally[peak][motif]))
        else:
            outf.write('\t')
    outf.write('\n')
    

                                                                                                                                                      
    
