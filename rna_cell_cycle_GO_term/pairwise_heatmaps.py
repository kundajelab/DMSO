import numpy as np 
data=open('rsem.fpkm.cell.cycle.averaged.reps.tsv','r').read().strip().split('\n')
header=data[0] 
#lateG1 vs SG2M
outf_scatter1=open('lateG1_vs_SG2M_scatter.txt','w')
outf_scatter1.write('DMSO_lateG1_vs_SG2M_log2FC\tControl_lateG1_vs_SG2M_log2FC\n')
outf_heatmap_up1=open('lateG1_vs_SG2M_Up_heatmap.txt','w')
outf_heatmap_up1.write(header+'\n') 
outf_heatmap_down1=open('lateG1_vs_SG2M_Down_heatmap.txt','w')
outf_heatmap_down1.write(header+'\n') 
#earlyG1 vs SG2M
outf_scatter2=open('earlyG1_vs_SG2M_scatter.txt','w')
outf_scatter2.write('DMSO_earlyG1_vs_SG2M_log2FC\tControl_earlyG1_vs_SG2M_log2FC\n') 
outf_heatmap_up2=open('earlyG1_vs_SG2M_Up_heatmap.txt','w')
outf_heatmap_up2.write(header+'\n') 
outf_heatmap_down2=open('earlyG1_vs_SG2M_Down_heatmap.txt','w')
outf_heatmap_down2.write(header+'\n') 
#lateG1 vs earlyG1
outf_scatter3=open('lateG1_vs_earlyG1_scatter.txt','w')
outf_scatter3.write('DMSO_lateG1_vs_earlyG1_log2FC\tControl_lateG1_vs_earlyG1_log2FC\n') 
outf_heatmap_up3=open('lateG1_vs_earlyG1_Up_heatmap.txt','w')
outf_heatmap_up3.write(header+'\n') 
outf_heatmap_down3=open('lateG1_vs_earlyG1_Down_heatmap.txt','w')
outf_heatmap_down3.write(header+'\n') 
for line in data[1::]:
    tokens=line.split('\t')
    gene=tokens[0]
    val=[float(i) for i in tokens[1::]]
    logvals=[]
    for i in val:
        if i >0:
            logvals.append(np.log2(i))
        else:
            logvals.append(0)
    if val[2]==0:
        lateG1_vs_SG2M_control=val[1]
    else:
        lateG1_vs_SG2M_control=val[1]/val[2]
    if lateG1_vs_SG2M_control >0:
        lateG1_vs_SG2M_control=np.log2(lateG1_vs_SG2M_control) 
    if val[5]==0:
        lateG1_vs_SG2M_dmso=val[4]
    else:
        lateG1_vs_SG2M_dmso=val[4]/val[5]
    if lateG1_vs_SG2M_dmso >0:
        lateG1_vs_SG2M_dmso=np.log2(lateG1_vs_SG2M_dmso)
    outf_scatter1.write(str(lateG1_vs_SG2M_dmso)+'\t'+str(lateG1_vs_SG2M_control)+'\n')
    if ((lateG1_vs_SG2M_dmso >1) and (abs(lateG1_vs_SG2M_control)<1)):
        outf_heatmap_up1.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')
    if ((lateG1_vs_SG2M_dmso <-1) and (abs(lateG1_vs_SG2M_control)<1)):
        outf_heatmap_down1.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')

    if val[2]==0:
        earlyG1_vs_SG2M_control=val[0]
    else:
        earlyG1_vs_SG2M_control=val[0]/val[2]
    if earlyG1_vs_SG2M_control >0:
        earlyG1_vs_SG2M_control=np.log2(earlyG1_vs_SG2M_control) 
    if val[5]==0:
        earlyG1_vs_SG2M_dmso=val[3]
    else:
        earlyG1_vs_SG2M_dmso=val[3]/val[5]
    if earlyG1_vs_SG2M_dmso >0:
        earlyG1_vs_SG2M_dmso=np.log2(earlyG1_vs_SG2M_dmso)
    outf_scatter2.write(str(earlyG1_vs_SG2M_dmso)+'\t'+str(earlyG1_vs_SG2M_control)+'\n')
    if ((earlyG1_vs_SG2M_dmso >1) and (abs(earlyG1_vs_SG2M_control)<1)):
        outf_heatmap_up2.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')
    if ((earlyG1_vs_SG2M_dmso <-1) and (abs(earlyG1_vs_SG2M_control)<1)):
        outf_heatmap_down2.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')


    if val[0]==0:
        lateG1_vs_earlyG1_control=val[1]
    else:
        lateG1_vs_earlyG1_control=val[1]/val[0]
    if lateG1_vs_earlyG1_control >0:
        lateG1_vs_earlyG1_control=np.log2(lateG1_vs_earlyG1_control) 
    if val[3]==0:
        lateG1_vs_earlyG1_dmso=val[4]
    else:
        lateG1_vs_earlyG1_dmso=val[4]/val[3]
    if lateG1_vs_earlyG1_dmso >0:
        lateG1_vs_earlyG1_dmso=np.log2(lateG1_vs_earlyG1_dmso)
    outf_scatter3.write(str(lateG1_vs_earlyG1_dmso)+'\t'+str(lateG1_vs_earlyG1_control)+'\n')
    if ((lateG1_vs_earlyG1_dmso >1) and (abs(lateG1_vs_earlyG1_control)<1)):
        outf_heatmap_up3.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')
    if ((lateG1_vs_earlyG1_dmso <-1) and (abs(lateG1_vs_earlyG1_control)<1)):
        outf_heatmap_down3.write(gene+'\t'+'\t'.join([str(i) for i in logvals])+'\n')
