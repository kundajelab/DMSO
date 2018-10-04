import math 
prefix=['earlyG1.up','earlyG1.down','lateG1.up','lateG1.down','SG2M.up','SG2M.down']
#suffix='.table.txt'
suffix='.table.txt.full'
#outf=open("bar_graph_input.txt",'w')
outf=open("bar_graph_input.full.txt",'w')
outf.write("Pathway\t-10log10FDR\tGroup\n")
for p in prefix:
    data=open(p+suffix,'r').read().strip().split('\n')
    for line in data[1::]:
        tokens=line.split('\t')
        path=tokens[0]
        fdr=float(tokens[-2])
        if fdr > 0.05:
            continue 
        fdr=str(-10*math.log10(fdr))
        outf.write(path+'\t'+fdr+'\t'+p+'\n')
        

