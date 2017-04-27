#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated'

# SYS command. line 103

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 106

 intersectBed -wo -a <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz) -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/rep1/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5.pf.pval0.1.500K.narrowPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-10 | sort | uniq | intersectBed -wo -a stdin -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/rep2/H9_Fucci_LateG1_R2_D2_S42_L005_R1_001.trim.PE2SE.nodup.tn5.pf.pval0.1.500K.narrowPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-10 | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.narrowPeak.gz

# SYS command. line 109

 intersectBed -wo -a <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz) -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-10 | sort | uniq | intersectBed -wo -a stdin -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr2/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.pr2.tn5_pooled.pf.pval0.1.500K.narrowPeak.gz) |    awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-10 | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.narrowPeak.gz

# SYS command. line 112

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.narrowPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.narrowPeak.gz | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.naive_overlap.narrowPeak.gz

# SYS command. line 114

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.narrowPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/macs2/overlap/H9_Fucci_LateG1_R2_D1_S41_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.narrowPeak.gz

# SYS command. line 116

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
