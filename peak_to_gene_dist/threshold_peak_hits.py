import pandas as pd
import sys 
data=pd.read_table("all.diffpeaks.tsv")
thresh_e2=data[data['padj']<0.01]
thresh_e3=data[data['padj']<0.001]
thresh_e4=data[data['padj']<0.0001]
thresh_e5=data[data['padj']<0.00001]
#write the thresholded output files
thresh_e2.to_csv('diff_peaks_e2.tsv',sep='\t')
thresh_e3.to_csv('diff_peaks_e3.tsv',sep='\t')
thresh_e4.to_csv('diff_peaks_e4.tsv',sep='\t')
thresh_e5.to_csv('diff_peaks_e5.tsv',sep='\t')




