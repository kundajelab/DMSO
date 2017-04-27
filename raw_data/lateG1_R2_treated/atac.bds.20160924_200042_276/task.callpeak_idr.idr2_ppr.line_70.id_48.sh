#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated'

# SYS command. line 72

 if [[ -f $(which conda) && $(conda env list | grep bds_atac_py3 | wc -l) != "0" ]]; then source activate bds_atac_py3; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 74

 idr --samples /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr2/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.pr2.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz --peak-list /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz --input-file-type narrowPeak \
			--output-file /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.unthresholded-peaks.txt --rank p.value --soft-idr-threshold 0.1 \
			--plot --use-best-multisummit-IDR

# SYS command. line 78

 idr_thresh_transformed=$(awk -v p=0.1 'BEGIN{print -log(p)/log(10)}')

# SYS command. line 81

 awk 'BEGIN{OFS="\t"} $12>='"${idr_thresh_transformed}"' {if ($2<0) $2=0; print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,"0"}' /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.unthresholded-peaks.txt \
			| sort | uniq | sort -k7n,7n | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.13-col.bed.gz

# SYS command. line 84

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.13-col.bed.gz | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.narrowPeak.gz

# SYS command. line 85

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.13-col.bed.gz | awk 'BEGIN{OFS="\t"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.12-col.bed.gz

# SYS command. line 87

 bedtools intersect -v -a /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.13-col.bed.gz -b /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/blacklist_idr/wgEncodeDacMapabilityConsensusExcludable.bed.gz | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.13-col.bed.gz

# SYS command. line 88

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.13-col.bed.gz | awk 'BEGIN{OFS="	"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.narrowPeak.gz

# SYS command. line 89

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.13-col.bed.gz | awk 'BEGIN{OFS="	"} {print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.12-col.bed.gz

# SYS command. line 91

 gzip -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.unthresholded-peaks.txt

# SYS command. line 92

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.13-col.bed.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.13-col.bed.gz

# SYS command. line 94

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
