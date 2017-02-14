#gzip -d earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/*gz 

##gzip-d lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/*gz 

#gzip -d SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr2/*gz 
#gzip -d SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/*gz 
#gzip -d SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr2/*gz 

gzip -d controls/output_controls/align/pooled_pseudo_reps/ppr1/*gz
gzip -d controls/output_controls/align/pooled_pseudo_reps/ppr2/*gz


python shift_atac_tagalign.py controls/output_controls/align/pooled_pseudo_reps/ppr1/*tagAlign controls/output_controls/align/pooled_pseudo_reps/ppr1/slopped
python shift_atac_tagalign.py controls/output_controls/align/pooled_pseudo_reps/ppr2/*tagAlign controls/output_controls/align/pooled_pseudo_reps/ppr2/slopped

bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b controls/output_controls/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > batch1_controls_pr1
bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b controls/output_controls/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > batch1_controls_pr2 


gzip -d dmso/output_dmso/align/pooled_pseudo_reps/ppr1/*gz
gzip -d dmso/output_dmso/align/pooled_pseudo_reps/ppr2/*gz


python shift_atac_tagalign.py dmso/output_dmso/align/pooled_pseudo_reps/ppr1/*tagAlign dmso/output_dmso/align/pooled_pseudo_reps/ppr1/slopped
python shift_atac_tagalign.py dmso/output_dmso/align/pooled_pseudo_reps/ppr2/*tagAlign dmso/output_dmso/align/pooled_pseudo_reps/ppr2/slopped

bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b dmso/output_dmso/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > batch1_dmso_pr1
bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b dmso/output_dmso/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > batch1_dmso_pr2 


##qsub -N earlyG1_R1_controls.ppr1 -cwd -b y -o earlyG1_R1_controls.ppr1.LOG -e earlyG1_R1_controls.ppr1.ERR python shift_atac_tagalign.py earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N earlyG1_R1_controls.ppr2 -cwd -b y -o earlyG1_R1_controls.ppr2.LOG -e earlyG1_R1_controls.ppr2.ERR python shift_atac_tagalign.py earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped

##bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > earlyG1_R1_controls_pr1 
#qsub -N earlyG1_R1_controls.ppr2 -cwd -b y -o earlyG1_R1_controls.ppr2.LOG -e earlyG1_R1_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > earlyG1_R1_controls_pr2


##qsub -N earlyG1_R1_treated.ppr1 -cwd -b y -o earlyG1_R1_treated.ppr1.LOG -e earlyG1_R1_treated.ppr1.ERR python shift_atac_tagalign.py earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N earlyG1_R1_treated.ppr2 -cwd -b y -o earlyG1_R1_treated.ppr2.LOG -e earlyG1_R1_treated.ppr2.ERR python shift_atac_tagalign.py earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N earlyG1_R1_treated.ppr1 -cwd -b y -o earlyG1_R1_treated.ppr1.LOG -e earlyG1_R1_treated.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > earlyG1_R1_treated_pr1 
#qsub -N earlyG1_R1_treated.ppr2 -cwd -b y -o earlyG1_R1_treated.ppr2.LOG -e earlyG1_R1_treated.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > earlyG1_R1_treated_pr2


##qsub -N earlyG1_R2_controls.ppr1 -cwd -b y -o earlyG1_R2_controls.ppr1.LOG -e earlyG1_R2_controls.ppr1.ERR python shift_atac_tagalign.py earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N earlyG1_R2_controls.ppr2 -cwd -b y -o earlyG1_R2_controls.ppr2.LOG -e earlyG1_R2_controls.ppr2.ERR  python shift_atac_tagalign.py earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N earlyG1_R2_controls.ppr1 -cwd -b y -o earlyG1_R2_controls.ppr1.LOG -e earlyG1_R2_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > earlyG1_R2_controls_pr1 
#qsub -N earlyG1_R2_controls.ppr2 -cwd -b y -o earlyG1_R2_controls.ppr2.LOG -e earlyG1_R2_controls.ppr2.ERR  
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > earlyG1_R2_controls_pr2


##qsub -N earlyG1_R2_treated.ppr1 -cwd -b y -o earlyG1_R2_treated.ppr1.LOG -e earlyG1_R2_controls.ppr1.ERR python shift_atac_tagalign.py earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N earlyG1_R2_treated.ppr2 -cwd -b y -o earlyG1_R2_treated.ppr2.LOG -e earlyG1_R2_controls.ppr2.ERR python shift_atac_tagalign.py earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N earlyG1_R2_treated.ppr1 -cwd -b y -o earlyG1_R2_treated.ppr1.LOG -e earlyG1_R2_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > earlyG1_R2_treated_pr1 
#qsub -N earlyG1_R2_treated.ppr2 -cwd -b y -o earlyG1_R2_treated.ppr2.LOG -e earlyG1_R2_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b earlyG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > earlyG1_R2_treated_pr2


##qsub -N lateG1_R1_controls.ppr1 -cwd -b y -o lateG1_R1_controls.ppr1.LOG -e lateG1_R1_controls.ppr1.ERR python shift_atac_tagalign.py lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N lateG1_R1_controls.ppr2 -cwd -b y -o lateG1_R1_controls.ppr2.LOG -e lateG1_R1_controls.ppr2.ERR python shift_atac_tagalign.py lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N lateG1_R1_controls.ppr1 -cwd -b y -o lateG1_R1_controls.ppr1.LOG -e lateG1_R1_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > lateG1_R1_controls_pr1 
#qsub -N lateG1_R1_controls.ppr2 -cwd -b y -o lateG1_R1_controls.ppr2.LOG -e lateG1_R1_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > lateG1_R1_controls_pr2


##qsub -N lateG1_R1_treated.ppr1 -cwd -b y -o lateG1_R1_treated.ppr1.LOG -e lateG1_R1_treated.ppr1.ERR  python shift_atac_tagalign.py lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N lateG1_R1_treated.ppr2 -cwd -b y -o lateG1_R1_treated.ppr2.LOG -e lateG1_R1_treated.ppr2.ERR python shift_atac_tagalign.py lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N lateG1_R1_treated.ppr1 -cwd -b y -o lateG1_R1_treated.ppr1.LOG -e lateG1_R1_treated.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > lateG1_R1_treated_pr1 
#qsub -N lateG1_R1_treated.ppr2 -cwd -b y -o lateG1_R1_treated.ppr2.LOG -e lateG1_R1_treated.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > lateG1_R1_treated_pr2


##qsub -N lateG1_R2_controls.ppr1 -cwd -b y -o lateG1_R2_controls.ppr1.LOG -e lateG1_R2_controls.ppr1.ERR python shift_atac_tagalign.py lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N lateG1_R2_controls.ppr2 -cwd -b y -o lateG1_R2_controls.ppr2.LOG -e lateG1_R2_controls.ppr2.ERR python shift_atac_tagalign.py lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N lateG1_R2_controls.ppr1 -cwd -b y -o lateG1_R2_controls.ppr1.LOG -e lateG1_R2_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > lateG1_R2_controls_pr1 
#qsub -N lateG1_R2_controls.ppr2 -cwd -b y -o lateG1_R2_controls.ppr2.LOG -e lateG1_R2_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > lateG1_R2_controls_pr2


##qsub -N lateG1_R2_treated.ppr1 -cwd -b y -o lateG1_R2_treated.ppr1.LOG -e lateG1_R2_treated.ppr1.ERR python shift_atac_tagalign.py lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N lateG1_R2_treated.ppr2 -cwd -b y -o lateG1_R2_treated.ppr2.LOG -e lateG1_R2_treated.ppr2.ERR python shift_atac_tagalign.py lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N lateG1_R2_treated.ppr1 -cwd -b y -o lateG1_R2_treated.ppr1.LOG -e lateG1_R2_treated.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > lateG1_R2_treated_pr1 
#qsub -N lateG1_R2_treated.ppr2 -cwd -b y -o lateG1_R2_treated.ppr2.LOG -e lateG1_R2_treated.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b lateG1_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > lateG1_R2_treated_pr2

##qsub -N SG2M_R1_controls.ppr1 -cwd -b y -o SG2M_R1_controls.ppr1.LOG -e SG2M_R1_controls.ppr1.ERR python shift_atac_tagalign.py SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N SG2M_R1_controls.ppr2 -cwd -b y -o SG2M_R1_controls.ppr2.LOG -e SG2M_R1_controls.ppr2.ERR python shift_atac_tagalign.py SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N SG2M_R1_controls.ppr1 -cwd -b y -o SG2M_R1_controls.ppr1.LOG -e SG2M_R1_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > SG2M_R1_controls_pr1 
#qsub -N SG2M_R1_controls.ppr2 -cwd -b y -o SG2M_R1_controls.ppr2.LOG -e SG2M_R1_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R1_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > SG2M_R1_controls_pr2


##qsub -N SG2M_R1_treated.ppr1 -cwd -b y -o SG2M_R1_treated.ppr1.LOG -e SG2M_R1_treated.ppr1.ERR python shift_atac_tagalign.py SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr1/sloppedp
##qsub -N SG2M_R1_treated.ppr2 -cwd -b y -o SG2M_R1_treated.ppr2.LOG -e SG2M_R1_treated.ppr2.ERR python shift_atac_tagalign.py SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N SG2M_R1_treated.ppr1 -cwd -b y -o SG2M_R1_treated.ppr1.LOG -e SG2M_R1_treated.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > SG2M_R1_treated_pr1 
#qsub -N SG2M_R1_treated.ppr2 -cwd -b y -o SG2M_R1_treated.ppr2.LOG -e SG2M_R1_treated.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R1_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > SG2M_R1_treated_pr2


##qsub -N SG2M_R2_controls.ppr1 -cwd -b y -o SG2M_R2_controls.ppr1.LOG -e SG2M_R2_controls.ppr1.ERR python shift_atac_tagalign.py SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr1/*tagAlign SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N SG2M_R2_controls.ppr2 -cwd -b y -o SG2M_R2_controls.ppr2.LOG -e SG2M_R2_controls.ppr2.ERR python shift_atac_tagalign.py SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr2/*tagAlign SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N SG2M_R2_controls.ppr1 -cwd -b y -o SG2M_R2_controls.ppr1.LOG -e SG2M_R2_controls.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > SG2M_R2_controls_pr1 
#qsub -N SG2M_R2_controls.ppr2 -cwd -b y -o SG2M_R2_controls.ppr2.LOG -e SG2M_R2_controls.ppr2.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R2_controls/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > SG2M_R2_controls_pr2


##qsub -N SG2M_R2_treated.ppr1 -cwd -b y -o SG2M_R2_treated.ppr1.LOG -e SG2M_R2_treated.ppr1.ERR python shift_atac_tagalign.py SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/*tagAlign SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped
##qsub -N SG2M_R2_treated.ppr2 -cwd -b y -o SG2M_R2_treated.ppr2.LOG -e SG2M_R2_treated.ppr2.ERR python shift_atac_tagalign.py SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr2/*tagAlign SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped
#qsub -N SG2M_R2_treated.ppr1 -cwd -b y -o SG2M_R2_treated.ppr1.LOG -e SG2M_R2_treated.ppr1.ERR 
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/slopped | cut -f4 > SG2M_R2_treated_pr1 
#qsub -N SG2M_R2_treated.ppr2 -cwd -b y -o SG2M_R2_treated.ppr2.LOG -e SG2M_R2_treated.ppr2.ERR  
#bedtools coverage -counts -a merged_peaks/ppr.merged.bed -b SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr2/slopped | cut -f4 > SG2M_R2_treated_pr2
