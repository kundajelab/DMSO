differential=['filtered.h3k27ac.differential','filtered.h3k4me3.differential','filtered.h3k27me3.differential']
present=['filtered.h3k27ac.present','filtered.h3k4me3.present','filtered.h3k27me3.present']
peak_dict=dict()
state_dict=dict()
outf=open('aggregate_summary.txt','w')
outf.write('Chromatin_State\tChrom\tStart\tEnd\tH3K27ac_fc\tH3K27ac_present\tH3K4me3_fc\tH3K4me3_present\tH3K27me3_fc\tH3K27me3_present\n')
for i in range(3):
    data=open(differential[i],'r').read().strip().split('\n')
    for line in data:
        tokens=line.split('\t')
        state=tokens[3]
        peak='_'.join(tokens[0:3])
        fc=tokens[7]
        if peak not in peak_dict:
            peak_dict[peak]=dict()
        state_dict[peak]=state
        if fc !=".":
            peak_dict[peak][differential[i]]=fc
    data=open(present[i],'r').read().strip().split('\n')
    for line in data:
        tokens=line.split('\t')
        state=tokens[3]
        peak='_'.join(tokens[0:3])
        fc=tokens[7]
        if peak not in peak_dict:
            peak_dict[peak]=dict()
        state_dict[peak]=state
        if fc !="0":
            peak_dict[peak][present[i]]="1"
            
for peak in state_dict:
    outf.write(state_dict[peak]+'\t'+peak)
    for i in range(3):
        if differential[i] in peak_dict[peak]:
            outf.write('\t'+peak_dict[peak][differential[i]])
        else:
            outf.write('\t')
        if present[i] in peak_dict[peak]:
            outf.write('\t'+peak_dict[peak][present[i]])
        else:
            outf.write('\t')
    outf.write('\n')
    
            
        
        
        
