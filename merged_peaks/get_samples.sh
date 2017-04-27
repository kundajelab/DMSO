for run in earlyG1_R1_controls earlyG1_R1_treated earlyG1_R2_controls earlyG1_R2_treated lateG1_R1_controls lateG1_R1_treated lateG1_R2_controls lateG1_R2_treated SG2M_R1_controls SG2M_R1_treated SG2M_R2_controls SG2M_R2_treated 
do
bedtools intersect -a ../$run/out/peak/macs2/overlap/*narrowPeak.gz -b ppr.merged.bed -wb | cut -f11,12,13  >  $run.ppr.bed 
bedtools intersect -a ../$run/out/peak/idr/conservative_set/*narrowPeak.gz -b ppr.merged.bed -wb | cut -f11,12,13  > $run.idr.bed 
echo $i
done 
