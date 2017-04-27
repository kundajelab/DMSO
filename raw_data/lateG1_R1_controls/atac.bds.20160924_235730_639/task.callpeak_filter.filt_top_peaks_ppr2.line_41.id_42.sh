#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_controls'

# SYS command. line 43

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 46

 set +o pipefail

# SYS command. line 49

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/H9_Fucci_LateG1_C1_S27_L004_R1_001.trim.PE2SE.nodup.pr2.tn5_pooled.pf.pval0.1.gappedPeak.gz | sort -grk14 | head -n 500000 | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_controls/out/peak/macs2/pooled_pseudo_reps/ppr2/H9_Fucci_LateG1_C1_S27_L004_R1_001.trim.PE2SE.nodup.pr2.tn5_pooled.pf.pval0.1.500K.gappedPeak.gz

# SYS command. line 51

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
