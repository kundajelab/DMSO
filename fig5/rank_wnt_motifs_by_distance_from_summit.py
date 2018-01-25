summits=open("summits_for_wnt_peaks.bed",'r').read().strip().split('\n')
intersections=open("intersections.txt",'r').read().strip().split('\n')
outf=open('motif_distances_from_summit.txt','w')
summit_dict=dict()
for line in summits:
    tokens=line.split('\t')
    peak=tuple(tokens[0:4])
    summit_chrom=tokens[-3]
    summit_start=int(tokens[-2])
    summit_end=int(tokens[-1])
    summit_entry=(summit_chrom,summit_start,summit_end)
    if peak not in summit_dict:
        summit_dict[peak]=[summit_entry]
    else:
        summit_dict[peak].append(summit_entry)
    
print("built summit dict")
for line in intersections:
    tokens=line.split('\t')
    peak=tuple(tokens[0:4])
    peak_summits=summit_dict[peak]
    motif_start=int(tokens[5])
    min_dist=float("inf")
    for s in peak_summits:
        delta=motif_start-s[1]
        if abs(delta)< abs(min_dist):
            min_dist=delta
    outf.write(line+'\t'+str(min_dist)+'\n')
    
    


