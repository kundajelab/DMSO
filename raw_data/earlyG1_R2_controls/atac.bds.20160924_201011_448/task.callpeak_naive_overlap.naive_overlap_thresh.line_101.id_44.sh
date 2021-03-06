#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls'

# SYS command. line 103

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 106

 intersectBed -wo -a <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/pooled_rep/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.gappedPeak.gz) -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/rep1/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5.pf.pval0.1.500K.gappedPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$18-$17; if (($31/s1 >= 0.5) || ($31/s2 >= 0.5)) {print $0}}' | cut -f 1-15 | sort | uniq | intersectBed -wo -a stdin -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R1_001.trim.PE2SE.nodup.tn5.pf.pval0.1.500K.gappedPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$18-$17; if (($31/s1 >= 0.5) || ($31/s2 >= 0.5)) {print $0}}' | cut -f 1-15 | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.gappedPeak.gz

# SYS command. line 109

 intersectBed -wo -a <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/pooled_rep/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.gappedPeak.gz) -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.500K.gappedPeak.gz) | awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$18-$17; if (($31/s1 >= 0.5) || ($31/s2 >= 0.5)) {print $0}}' | cut -f 1-15 | sort | uniq | intersectBed -wo -a stdin -b <(zcat -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.pr2.tn5_pooled.pf.pval0.1.500K.gappedPeak.gz) |    awk 'BEGIN{FS="	";OFS="	"} {s1=$3-$2; s2=$18-$17; if (($31/s1 >= 0.5) || ($31/s2 >= 0.5)) {print $0}}' | cut -f 1-15 | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.gappedPeak.gz

# SYS command. line 112

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.gappedPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.gappedPeak.gz | sort | uniq | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.naive_overlap.gappedPeak.gz

# SYS command. line 114

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInReps.gappedPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/peak/macs2/overlap/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.PooledInPsRep1AndPsRep2.gappedPeak.gz

# SYS command. line 116

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
