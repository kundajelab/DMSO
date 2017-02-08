module load bedtools 

#concatenate the naive overlap files for the chipseq pipeline outputs
cat h3k27ac_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/*bed h3k27ac_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/*bed  h3k27me3_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/*bed  h3k27me3_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/*bed h3k4me3_noncellcycle_control/out/peak/macs2/overlap/*narrowPeak h3k4me3_noncellcycle_dmso/out/peak/macs2/overlap/*narrowPeak > chetty_chipseq_aggregate_files_cated_narrowPeak.bed 

#sort 
bedtools sort -i chetty_chipseq_aggregate_files_cated_narrowPeak.bed > chetty_chipseq_aggregate_files_cated_narrowPeak.sorted.bed
#run bedtools merge command to create a merged peak set 
bedtools merge -i chetty_chipseq_aggregate_files_cated_narrowPeak.sorted.bed > chetty_chipseq_aggregate_files_merged_narrowPeak.bed

#reverse-intersect the merged peak set with the individual pseudo-replicates 
bedtools intersect -wo -a h3k27ac_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27ac_control1 
bedtools intersect -wo -a h3k27ac_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27ac_control2
bedtools intersect -wo -a h3k27ac_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27ac_dmso1
bedtools intersect -wo -a h3k27ac_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27ac_dmso2

bedtools intersect -wo -a h3k27me3_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27me3_control1 
bedtools intersect -wo -a h3k27me3_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27me3_control2
bedtools intersect -wo -a h3k27me3_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27me3_dmso1
bedtools intersect -wo -a h3k27me3_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k27me3_dmso2


bedtools intersect -wo -a h3k4me3_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k4me3_control1 
bedtools intersect -wo -a h3k4me3_noncellcycle_control/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k4me3_control2
bedtools intersect -wo -a h3k4me3_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr1/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k4me3_dmso1
bedtools intersect -wo -a h3k4me3_noncellcycle_dmso/out/peak/macs2/pooled_pseudo_reps/ppr2/*narrowPeak  -b chetty_chipseq_aggregate_files_merged_narrowPeak.bed | cut -f7,11,12,13 > chip_h3k4me3_dmso2


#aggregate the pseudo-replicates into a single matrix of fold change counts. 
python combine_peak_sets.py
