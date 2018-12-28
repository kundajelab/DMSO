import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="aggregate HOMER hits")
    parser.add_argument("--tasks",nargs="+")
    parser.add_argument("--task_names_preferred",nargs="+")
    parser.add_argument("--outf")
    parser.add_argument("--log_pval_col",type=int)
    parser.add_argument("--motif_name_col",type=int)
    return parser.parse_args()

def main():
    args=parse_args()
    outf=open(args.outf,'w')
    outf.write('Motif\t'+'\t'.join(args.task_names_preferred)+'\n')
    motif_dict=dict()
    for i in range(len(args.tasks)):
        taskname=args.tasks[i]
        pref_taskname=args.task_names_preferred[i] 
        data=open("top15."+taskname,'r').read().strip().split('\n')
        for line in data:
            tokens=line.split('\t')
            motif_name=tokens[args.motif_name_col].split(':')[1].split('/')[0]
            pval=str(-1*float(tokens[args.log_pval_col]))
            if motif_name not in motif_dict:
                motif_dict[motif_name]=dict()
            motif_dict[motif_name][pref_taskname]=pval
    #write summary file
    for motif in motif_dict:
        outf.write(motif)
        for task in args.task_names_preferred:
            if task in motif_dict[motif]:
                outf.write('\t'+motif_dict[motif][task])
            else:
                outf.write('\t0')
        outf.write('\n')
        
            

if __name__=="__main__":
    main()
    
