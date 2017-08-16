#intersects motifs from three motif callers
#intersecgts consensus sequences from homer & meme
# reports p-values from homer & mem as well as NES values from i-cis target
import argparse
def parse_args():
    parser=argparse.ArgumentParser(description="intersect motifs from three motif callers")
    parser.add_argument("--homer_known_motifs")
    parser.add_argument("--meme_output")
    parser.add_argument("--icis_output")
    parser.add_argument("--outf")
    return parser.parse_args()


def main():
    args=parse_args()
    motif_to_pval=dict()
    consensus_to_pval=dict()
    homer_data=open(args.homer_known_motifs,'r').read().strip().split('\n')
    meme_data=open(args.meme_output,'r').read().strip().split('\n')
    icis_data=open(args.icis_output,'r').read().strip().split('\n')
    
    for line in homer_data[1::]:
        tokens=line.split('\t')
        name=tokens[0].split('(')[0].lower() 
        consensus=tokens[1]
        pval=tokens[4]
        if float(pval)<0.05:
            if name not in motif_to_pval:
                motif_to_pval[name]=dict()
            motif_to_pval[name]['homer']=pval
            if consensus not in consensus_to_pval:
                consensus_to_pval[consensus]=dict()
            consensus_to_pval[consensus]['homer']=pval
    for line in meme_data:
        tokens=line.split('\t')
        name=tokens[1].lower()
        consensus=tokens[2]
        pval=tokens[-1]
        if name not in motif_to_pval:
            motif_to_pval[name]=dict()
        motif_to_pval[name]['meme']=pval
        if consensus not in consensus_to_pval:
            consensus_to_pval[consensus]=dict()
        consensus_to_pval[consensus]['meme']=pval
    for line in icis_data:
        tokens=line.split('\t')
        name=tokens[0].lower() 
        consensus=tokens[1]
        nes=tokens[-1]
        if name!="": 
            if name not in motif_to_pval:
                motif_to_pval[name]=dict()
            motif_to_pval[name]['icis']=nes
        if consensus!="":
            if consensus not in consensus_to_pval:
                consensus_to_pval[consensus]=dict()
            consensus_to_pval[consensus]['icis']=nes
    outf=open(args.outf+'.name','w')
    outf.write('Motif\tHOMER_pval\tMEME_pval\tiCIS_nes\n')
    for motif in motif_to_pval:
        outf.write(motif)
        if 'homer' in motif_to_pval[motif]:
            outf.write('\t'+motif_to_pval[motif]['homer'])
        else:
            outf.write('\t')
        if 'meme' in motif_to_pval[motif]:
            outf.write('\t'+motif_to_pval[motif]['meme'])
        else:
            outf.write('\t')
        if 'icis' in motif_to_pval[motif]:
            outf.write('\t'+motif_to_pval[motif]['icis'])
        else:
            outf.write('\t')
        outf.write('\n') 
    outf=open(args.outf+'.consensus','w')
    outf.write('Consensus\tHOMER_pval\tMEME_pval\tiCIS_nes\n')
    for consensus in consensus_to_pval:
        outf.write(consensus)
        if 'homer' in consensus_to_pval[consensus]:
            outf.write('\t'+consensus_to_pval[consensus]['homer'])
        else:
            outf.write('\t')
        if 'meme' in consensus_to_pval[consensus]:
            outf.write('\t'+consensus_to_pval[consensus]['meme'])
        else:
            outf.write('\t')
        if 'icis' in consensus_to_pval[consensus]:
            outf.write('\t'+consensus_to_pval[consensus]['icis'])
        else:
            outf.write('\t')
        outf.write('\n') 
    
if __name__=="__main__":
    main()
    
