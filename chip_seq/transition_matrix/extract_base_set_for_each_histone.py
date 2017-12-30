import numpy as np

#extract the regions where DMSO or control samples have peak for given histone mark
thresh=5

source=open("../chipseq_merged.txt",'r').read().strip().split('\n')
header=source[0].split('\t')

colnames_dmso=["chip_h3k27ac_dmso1","chip_h3k27ac_dmso2"]
colnames_control=["chip_h3k27ac_control1","chip_h3k27ac_control2"]
outf=open("h3k27ac.chipseq_merged.gt5.bed",'w')
dmso_indices=[header.index(i) for i in colnames_dmso]
control_indices=[header.index(i) for i in colnames_control]
for line in source[1::]:
    tokens=line.split('\t')
    dmso_vals=np.mean([float(tokens[i]) for i in dmso_indices])
    control_vals=np.mean([float(tokens[i]) for i in control_indices])
    if ((dmso_vals > thresh) or (control_vals > thresh)):
        outf.write('\t'.join([str(i) for i in tokens[0:4]])+'\n')

colnames_dmso=["chip_h3k4me3_dmso1","chip_h3k4me3_dmso2"]
colnames_control=["chip_h3k4me3_control1","chip_h3k4me3_control2"]
outf=open("h3k4me3.chipseq_merged.gt5.bed",'w')
dmso_indices=[header.index(i) for i in colnames_dmso]
control_indices=[header.index(i) for i in colnames_control]
for line in source[1::]:
    tokens=line.split('\t')
    dmso_vals=np.mean([float(tokens[i]) for i in dmso_indices])
    control_vals=np.mean([float(tokens[i]) for i in control_indices])
    if ((dmso_vals > thresh) or (control_vals > thresh)):
        outf.write('\t'.join([str(i) for i in tokens[0:4]])+'\n')

colnames_dmso=["chip_h3k27me3_dmso1","chip_h3k27me3_dmso2"]
colnames_control=["chip_h3k27me3_control1","chip_h3k27me3_control2"]
outf=open("h3k27me3.chipseq_merged.gt5.bed",'w')
dmso_indices=[header.index(i) for i in colnames_dmso]
control_indices=[header.index(i) for i in colnames_control]
for line in source[1::]:
    tokens=line.split('\t')
    dmso_vals=np.mean([float(tokens[i]) for i in dmso_indices])
    control_vals=np.mean([float(tokens[i]) for i in control_indices])
    if ((dmso_vals > thresh) or (control_vals > thresh)):
        outf.write('\t'.join([str(i) for i in tokens[0:4]])+'\n')
