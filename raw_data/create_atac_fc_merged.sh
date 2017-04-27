#creates a merged peak set for ATAC-seq data.
#extracts individual pseudo-replicate pileup for the merged peak set
#the resulting output file can be used to perform differential peak analysis with limma voom
module load bedtools 
#use just the low-density (R1) ATAC-seq peaks
#for naive overlap 

#zcat /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_controls/out/peak/macs2/overlap/*narrowPeak.gz \
#     /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_treated/out/peak/macs2/overlap/*narrowPeak.gz \
#     /srv/scratch/annashch/dmso/raw_data/lateG1_R2_controls/out/peak/macs2/overlap/*narrowPeak.gz \
#     /srv/scratch/annashch/dmso/raw_data/lateG1_R2_treated/out/peak/macs2/overlap/*narrowPeak.gz \
#     /srv/scratch/annashch/dmso/raw_data/SG2M_R2_controls/out/peak/macs2/overlap/*narrowPeak.gz \
#     /srv/scratch/annashch/dmso/raw_data/SG2M_R2_treated/out/peak/macs2/overlap/*narrowPeak.gz > ATAC_batch_2_concat.bed

#for IDR
zcat /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_controls/out/peak/idr/optimal_set/*narrowPeak.gz \
     /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_treated/out/peak/idr/optimal_set/*narrowPeak.gz \
     /srv/scratch/annashch/dmso/raw_data/lateG1_R2_controls/out/peak/idr/optimal_set/*narrowPeak.gz \
     /srv/scratch/annashch/dmso/raw_data/lateG1_R2_treated/out/peak/idr/optimal_set/*narrowPeak.gz \
     /srv/scratch/annashch/dmso/raw_data/SG2M_R2_controls/out/peak/idr/optimal_set/*narrowPeak.gz \
     /srv/scratch/annashch/dmso/raw_data/SG2M_R2_treated/out/peak/idr/optimal_set/*narrowPeak.gz > ATAC_batch_2_concat.bed


#sort!
bedtools sort -i ATAC_batch_2_concat.bed > ATAC_batch_2_concat.sorted.bed

#merge!
bedtools merge -i ATAC_batch_2_concat.sorted.bed > ATAC_batch_2_concat.merged.bed

#intersect individual pseudo-reps with the merged peak set, pull out the fold change column (column 7 in the narrowPeak files)

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_earlyG1_ld_control_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_earlyG1_ld_control_pr2.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_earlyG1_ld_treated_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/earlyG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_earlyG1_ld_treated_pr2.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/lateG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_lateG1_ld_control_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/lateG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_lateG1_ld_control_pr2.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_lateG1_ld_treated_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_lateG1_ld_treated_pr2.bed


bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/SG2M_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_SG2M_ld_control_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/SG2M_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_SG2M_ld_control_pr2.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_SG2M_ld_treated_pr1.bed

bedtools intersect -wo -a /srv/scratch/annashch/dmso/raw_data/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr2/*.1.narrowPeak.gz  -b ATAC_batch_2_concat.merged.bed | cut -f7,11,12,13 > atac_SG2M_ld_treated_pr2.bed

    
#create list of files to include in the final merged peak file
rm file_list.txt 
files=( "atac_earlyG1_ld_control_pr1.bed" "atac_earlyG1_ld_control_pr2.bed" "atac_earlyG1_ld_treated_pr1.bed" "atac_earlyG1_ld_treated_pr2.bed" "atac_lateG1_ld_control_pr1.bed" "atac_lateG1_ld_control_pr2.bed" "atac_lateG1_ld_treated_pr1.bed" "atac_lateG1_ld_treated_pr2.bed" "atac_SG2M_ld_control_pr1.bed" "atac_SG2M_ld_control_pr2.bed" "atac_SG2M_ld_treated_pr1.bed" "atac_SG2M_ld_treated_pr2.bed" )
for f in "${files[@]}"
do
 echo $f >> file_list.txt
done


#generate tsv file of merged peaks x ld samples 
python combine_peak_sets.py --merged_peaks ATAC_batch_2_concat.merged.bed --file_list file_list.txt --o atac_batch2_merged_ld_fc.txt
