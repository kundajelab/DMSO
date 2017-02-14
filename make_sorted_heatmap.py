import argparse
import sys
import pdb
import numpy as np
import itertools
import operator 

def parse_args():
    parser=argparse.ArgumentParser(description="takes output from differential analysis in limma voom and creates ordered input for a heatmap")
    parser.add_argument("--differential",nargs="+",help="space-separated list of differential peaks for each task")
    parser.add_argument("--normalized_fc",type=str,help="file of normalized fc values")
    parser.add_argument("--peak_to_gene",type=str,help="associations of peak positions to gene values, generally obtained from GREAT",default=None)
    parser.add_argument("--out",type=str,help="name of output file")
    if (len(sys.argv)==1)\
       or ('-h' in sys.argv)\
       or ('--h' in sys.argv)\
       or ('--help' in sys.argv)\
       or ('-help' in sys.argv):
        parser.print_help()
        sys.exit(1)
    return parser.parse_args() 

def get_fc_dictionaries(normalized_fc):
    header=normalized_fc[0].split('\t')
    header=[header[i] for i in range(1,len(header),2)]
    normalized_fc_dict=dict()
    for i in range(1,len(normalized_fc)):
        line=normalized_fc[i]
        tokens=line.split('\t')
        #average adjacent columns
        fc_vals=[float(j) for j in tokens[1::]]
        fc_vals=[sum(fc_vals[k:k+2])*.5 for k in range(0,len(fc_vals),2)]
        peak=tokens[0]
        normalized_fc_dict[peak]=fc_vals
    return header,normalized_fc_dict


def get_peak_to_gene_dict(peak_to_gene):
    peak_to_gene_dict=dict()
    for line in peak_to_gene[1::]:
        tokens=line.split('\t')
        peak_entry="_".join(tokens[0:3])
        peak_to_gene_dict[peak_entry]=tokens[-1]
    return peak_to_gene_dict


def get_differential_fold_change(differential_files):
    differential_vals=dict()
    numtasks=len(differential_files) # handle case for up & down regulation separately!
    for i in range(numtasks):
        fc_data=open(differential_files[i],'r').read().strip().replace('"','').split('\n')
        for line in fc_data[1::]:
            tokens=line.split('\t')
            fc=float(tokens[0])
            peak=tokens[-1]
            if peak not in differential_vals:
                differential_vals[peak]=[0]*numtasks 
            differential_vals[peak][i]=fc
    return differential_vals 

#assign each peak to the appropriate cluster combination of upregulated, no change, and downregulated task values 
def get_clusters(differential_vals,numtasks):
    clusters=dict()
    for peak in differential_vals:
        cluster_assignment=tuple(np.sign(differential_vals[peak]))
        if cluster_assignment not in clusters:
            clusters[cluster_assignment]=dict() 
        #store the maximum fold change, used for ranking clusters 
        fc=sum(differential_vals[peak])/len(differential_vals[peak])
        clusters[cluster_assignment][peak]=fc
    return clusters,list(clusters.keys())

#sort each peak cluster by max fold change value of peak in that cluster 
def sort_clusters(peak_clusters,cluster_keys):
    cluster_keys.sort()
    cluster_keys.reverse() 
    peak_list=[]
    peak_cluster=[]
    for key in cluster_keys:
        sorted_entries=sorted(peak_clusters[key].items(),key=operator.itemgetter(1))
        sorted_entries.reverse() #go from max to min
        for entry in sorted_entries:
            peak_list.append(entry[0])
            peak_cluster.append(key)
    return peak_list,peak_cluster 
        

def main():
    args=parse_args()
    normalized_fc=open(args.normalized_fc,'r').read().strip().replace('"','').split('\n')
    if args.peak_to_gene!=None:
        peak_to_gene=open(args.peak_to_gene,'r').read().strip().replace('"','').split('\n')
        peak_to_gene_dict=get_peak_to_gene_dict(peak_to_gene)            
    else:
        peak_to_gene=None 
    header,normalized_fc_dict=get_fc_dictionaries(normalized_fc)
    #generate dictionary of differential peak values 
    differential_vals=get_differential_fold_change(args.differential)
    numtasks=len(args.differential)
    #cluster by tasks, within each task, sort by fc
    peak_clusters,cluster_labels=get_clusters(differential_vals,numtasks)
    #sort each cluster by fold change
    ordered_peaks,cluster_assignments=sort_clusters(peak_clusters,cluster_labels)
    #write the normalized fold change values to output file
    outf=open(args.out,'w')
    if peak_to_gene!=None: 
        outf.write('Cluster\tPeak\tGREAT Gene Map\t'+'\t'.join(header)+'\n')
    else:
        outf.write('Cluster\tGREAT Gene Map\t'+'\t'.join(header)+'\n')
    for i in range(len(ordered_peaks)):
        cur_cluster=cluster_assignments[i]
        cur_peak=ordered_peaks[i]
        cur_fc=normalized_fc_dict[cur_peak]
        if peak_to_gene!=None:
            try:
                cur_gene=peak_to_gene_dict[cur_peak]
                outf.write(str(cur_cluster)+'\t'+cur_peak+'\t'+cur_gene+'\t'+'\t'.join([str(i) for i in cur_fc])+'\n')
            except:
                outf.write(str(cur_cluster)+'\t'+cur_peak+'\t'+'\t'+'\t'.join([str(i) for i in cur_fc])+'\n')
        else:
            outf.write(str(cur_cluster)+'\t'+cur_peak+'\t'+'\t'.join([str(i) for i in cur_fc])+'\n')
if __name__=="__main__":
    main()
    
