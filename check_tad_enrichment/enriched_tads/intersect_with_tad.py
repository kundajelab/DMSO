import argparse
import pdb 
def parse_args():
    parser=argparse.ArgumentParser(description="intersect tad regions with provided list of peaks and/or genes")
    parser.add_argument("--tads")
    parser.add_argument("--genes",default=None)
    parser.add_argument("--peaks",default=None)
    return parser.parse_args()

def main():
    args=parse_args()
    tads=open(args.tads,'r').read().strip().split('\n')
    tad_dict=dict()
    for tad in tads:
        tokens=tad.split('\t')
        chrom=tokens[0]
        startval=int(tokens[1])
        endval=int(tokens[2])
        if chrom not in tad_dict:
            tad_dict[chrom]=dict()
        tad_dict[chrom][tuple([chrom,startval,endval])]=1
    print("loaded tads!")
    print(str(tad_dict))
    if args.genes!=None:
        gene_hits=dict() 
        genes=open(args.genes,'r').read().strip().split('\n')
        for line in genes:
            tokens=line.split('\t')
            chrom=tokens[0]
            startval=int(tokens[1])
            endval=int(tokens[2])
            try:
                options=tad_dict[chrom]
            except:
                continue
            #pdb.set_trace() 
            for option in options:
                minval=option[1]
                maxval=option[2]
                if ((minval <=startval) and (maxval>=endval)):
                    if option not in gene_hits:
                        gene_hits[option]=[]
                    gene_hits[option].append(line)
                    break
        for tad in gene_hits:
            outf=open('_'.join(tad)+'.gene_hits','w')
            outf.write('\n'.join(gene_hits[tad]))
                        
    if args.peaks!=None:
        peak_hits=dict() 
        peaks=open(args.peaks,'r').read().strip().split('\n')
        for line in peaks:
            tokens=line.split('\t')
            chrom=tokens[0]
            startval=int(tokens[1])
            endval=int(tokens[2])
            try:
                options=tad_dict[chrom]
            except:
                continue 
            for option in options:
                minval=option[1]
                maxval=option[2]
                if ((minval <=startval) and (maxval>=endval)):
                    if option not in peak_hits:
                        peak_hits[option]=[]
                    peak_hits[option].append(line)
                    break
        for tad in peak_hits:
            outf=open('_'.join(tad)+'.peak_hits','w')
            outf.write('\n'.join(peak_hits[tad]))

if __name__=="__main__":
    main()
    
