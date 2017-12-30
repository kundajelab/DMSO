from pybedtools import BedTool
import pdb 
def get_sources(): 
    #generate bedtool objects for all chip-seq datasets
    h3k27ac=BedTool("h3k27ac.naiveoverlap.bed")
    #h3k4me3=BedTool("h3k4me3.naiveoverlap.bed")
    h3k4me3=BedTool("h3k4me3.chipseq_merged.gt5.bed") 
    h3k27me3=BedTool("h3k27me3.naiveoverlap.bed")
    print("generated bedtool objects")
    #extract the peaks specific to this cluster
    return h3k27ac,h3k4me3,h3k27me3

def get_diff_dict():
    #create dictionaries of differential peaks
    h3k27ac_up=open("h3k27ac_up",'r').read().strip().split('\n')
    h3k27ac_down=open("h3k27ac_down",'r').read().strip().split('\n')

    h3k27me3_up=open("h3k27me3_up",'r').read().strip().split('\n')
    h3k27me3_down=open("h3k27me3_down",'r').read().strip().split('\n')

    h3k4me3_up=open("h3k4me3_up",'r').read().strip().split('\n')
    h3k4me3_down=open("h3k4me3_down",'r').read().strip().split('\n')


    diff_dict=dict()
    diff_dict['h3k27ac_up']=dict()
    diff_dict['h3k27ac_down']=dict()
    diff_dict['h3k4me3_up']=dict()
    diff_dict['h3k4me3_down']=dict()
    diff_dict['h3k27me3_up']=dict()
    diff_dict['h3k27me3_down']=dict()
    for line in h3k27ac_up:
        diff_dict['h3k27ac_up'][tuple(line.split('\t'))]=1
    for line in h3k27ac_down:
        diff_dict['h3k27ac_down'][tuple(line.split('\t'))]=1
    for line in h3k4me3_up:
        diff_dict['h3k4me3_up'][tuple(line.split('\t'))]=1
    for line in h3k4me3_down:
        diff_dict['h3k4me3_down'][tuple(line.split('\t'))]=1
    for line in h3k27me3_up:
        diff_dict['h3k27me3_up'][tuple(line.split('\t'))]=1
    for line in h3k27me3_down:
        diff_dict['h3k27me3_down'][tuple(line.split('\t'))]=1
    print('generated dictionaries of differential chipseq peaks')
    return diff_dict 

def get_transition_matrix_cluster(h3k27ac,h3k4me3,h3k27me3,diff_dict,cluster_index):
    intervals=BedTool("/srv/scratch/annashch/dmso/dp_gp/dpgp_diff_peaks_fold/"+str(cluster_index)+".bed")
    intersection_h3k27ac=intervals.closest(h3k27ac,wao=True)
    intersection_h3k4me3=intervals.closest(h3k4me3,wao=True)
    intersection_h3k27me3=intervals.closest(h3k27me3,wao=True)
    results=dict() 
    for i in range(len(intervals)):
        if i%100==0:
            print(i) 
        cur_interval=tuple(intersection_h3k27ac[i][0:3])
        results[cur_interval]=dict()
        results[cur_interval]['dmso']=[0,0,0] #h3k27ac, h3k4me3, h3k27me3
        results[cur_interval]['control']=[0,0,0] 
        #determine which of 6 possible mark combinations is represented for DMSO & Control
        if intersection_h3k27ac[i][3].startswith('c'):
            #is the h3k27ac mark differential or stable?
            overlap=tuple(intersection_h3k27ac[i][3:6])
            #is the peak up in dmso?
            if overlap in diff_dict['h3k27ac_up']:
                results[cur_interval]['dmso'][0]=1 
            #is the peak up in control? 
            elif overlap in diff_dict['h3k27ac_down']:
                results[cur_interval]['control'][0]=1 
            else:
                results[cur_interval]['dmso'][0]=1
                results[cur_interval]['control'][0]=1
        if intersection_h3k4me3[i][3].startswith('c'):
            #is the h3k4me3 mark differential or stable?
            overlap=tuple(intersection_h3k4me3[i][3:6])
            #is the peak up in dmso?
            if overlap in diff_dict['h3k4me3_up']:
                results[cur_interval]['dmso'][1]=1 
            #is the peak up in control? 
            elif overlap in diff_dict['h3k4me3_down']:
                results[cur_interval]['control'][1]=1 
            else:
                results[cur_interval]['dmso'][1]=1
                results[cur_interval]['control'][1]=1

        if intersection_h3k27me3[i][3].startswith('c'):
            #is the h3k27me3 mark differential or stable?
            overlap=tuple(intersection_h3k27me3[i][3:6])
            #is the peak up in dmso?
            if overlap in diff_dict['h3k27me3_up']:
                results[cur_interval]['dmso'][2]=1 
            #is the peak up in control? 
            elif overlap in diff_dict['h3k27me3_down']:
                results[cur_interval]['control'][2]=1 
            else:
                results[cur_interval]['dmso'][2]=1
                results[cur_interval]['control'][2]=1
    print("completed interval labels")
    #aggregate results into matrix
    transition_mat=dict()
    start_states=set([])
    end_states=set([]) 
    for interval in results:
        start_state=tuple(results[interval]['control'])
        end_state=tuple(results[interval]['dmso'])
        start_states.add(start_state)
        end_states.add(end_state) 
        if start_state not in transition_mat:
            transition_mat[start_state]=dict()
        if end_state not in transition_mat[start_state]:
            transition_mat[start_state][end_state]=1
        else:
            transition_mat[start_state][end_state]+=1
    outf=open("chipseq_transition_matrix_"+str(cluster_index)+".txt",'w')
    start_states=list(start_states)
    end_states=list(end_states)
    outf.write('\t'+'\t'.join([str(i) for i in end_states])+'\n')
    for s in start_states:
        outf.write(str(s))
        for e in end_states:
            if e in transition_mat[s]:
                outf.write('\t'+str(transition_mat[s][e]))
            else:
                outf.write('\t0')
        outf.write('\n')

def get_transition_matrix_global(h3k27ac,h3k4me3,h3k27me3,diff_dict):
    chromsizes=open("hg19.chrom.sizes",'r').read().strip().split('\n')
    window=2000
    results=dict()
    for line in chromsizes:
        tokens=line.split('\t')
        chrom=tokens[0]
        size=int(tokens[1])
        intervals=BedTool('\n'.join([chrom+'\t'+str(i)+'\t'+str(i+window) for i in range(1,size+2000,2000)]),from_string=True)
        print("generated intervals for chromosome:"+str(chrom))
        #get the intersection with each histone mark.
        intersection_h3k27ac=intervals.intersect(h3k27ac,wao=True)
        intersection_h3k4me3=intervals.intersect(h3k4me3,wao=True)
        intersection_h3k27me3=intervals.intersect(h3k27me3,wao=True)

        print("got intersections with histone marks")
        intersection_h3k27ac=[str(i).split('\t') for i in intersection_h3k27ac]
        intersection_h3k4me3=[str(i).split('\t') for i in intersection_h3k4me3]
        intersection_h3k27me3=[str(i).split('\t') for i in intersection_h3k27me3]
        for i in range(len(intervals)):
            if i%100==0:
                print(i) 
            cur_interval=tuple(intersection_h3k27ac[i][0:3])
            results[cur_interval]=dict()
            results[cur_interval]['dmso']=[0,0,0] #h3k27ac, h3k4me3, h3k27me3
            results[cur_interval]['control']=[0,0,0] 
            #determine which of 6 possible mark combinations is represented for DMSO & Control
            if intersection_h3k27ac[i][3].startswith('c'):
                #is the h3k27ac mark differential or stable?
                overlap=tuple(intersection_h3k27ac[i][3:6])
                #is the peak up in dmso?
                if overlap in diff_dict['h3k27ac_up']:
                    results[cur_interval]['dmso'][0]=1 
                #is the peak up in control? 
                elif overlap in diff_dict['h3k27ac_down']:
                    results[cur_interval]['control'][0]=1 
                else:
                    results[cur_interval]['dmso'][0]=1
                    results[cur_interval]['control'][0]=1
            if intersection_h3k4me3[i][3].startswith('c'):
                #is the h3k4me3 mark differential or stable?
                overlap=tuple(intersection_h3k4me3[i][3:6])
                #is the peak up in dmso?
                if overlap in diff_dict['h3k4me3_up']:
                    results[cur_interval]['dmso'][1]=1 
                #is the peak up in control? 
                elif overlap in diff_dict['h3k4me3_down']:
                    results[cur_interval]['control'][1]=1 
                else:
                    results[cur_interval]['dmso'][1]=1
                    results[cur_interval]['control'][1]=1

            if intersection_h3k27me3[i][3].startswith('c'):
                #is the h3k27me3 mark differential or stable?
                overlap=tuple(intersection_h3k27me3[i][3:6])
                #is the peak up in dmso?
                if overlap in diff_dict['h3k27me3_up']:
                    results[cur_interval]['dmso'][2]=1 
                #is the peak up in control? 
                elif overlap in diff_dict['h3k27me3_down']:
                    results[cur_interval]['control'][2]=1 
                else:
                    results[cur_interval]['dmso'][2]=1
                    results[cur_interval]['control'][2]=1
        print("completed interval labels")
    #aggregate results into matrix
    transition_mat=dict()
    start_states=set([])
    end_states=set([]) 
    for interval in results:
        start_state=tuple(results[interval]['control'])
        end_state=tuple(results[interval]['dmso'])
        start_states.add(start_state)
        end_states.add(end_state) 
        if start_state not in transition_mat:
            transition_mat[start_state]=dict()
        if end_state not in transition_mat[start_state]:
            transition_mat[start_state][end_state]=1
        else:
            transition_mat[start_state][end_state]+=1
    if (cluster_specific==False):
        outf=open("chipseq_transition_matrix_global.txt",'w')
    else:
        outf=open("chipseq_transition_matrix_"+str(cluster_index)+".txt",'w')
    start_states=list(start_states)
    end_states=list(end_states)
    #print(str(end_states))
    #print(str(end_states))
    outf.write('\t'+'\t'.join([str(i) for i in end_states])+'\n')
    for s in start_states:
        outf.write(str(s))
        for e in end_states:
            if e in transition_mat[s]:
                outf.write('\t'+str(transition_mat[s][e]))
            else:
                outf.write('\t0')
        outf.write('\n')

h3k27ac,h3k4me3,h3k27me3=get_sources()
diff_dict=get_diff_dict()
#get_transition_matrix_global(h3k27ac,h3k4me3,h3k27me3,diff_dict) 
for cluster_index in range(1,7):
    get_transition_matrix_cluster(h3k27ac,h3k4me3,h3k27me3,diff_dict,cluster_index=cluster_index) 
