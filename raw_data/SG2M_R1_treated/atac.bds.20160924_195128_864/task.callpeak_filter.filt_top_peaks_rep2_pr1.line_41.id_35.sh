#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated'

# SYS command. line 43

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 46

 set +o pipefail

# SYS command. line 49

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated/out/peak/macs2/pseudo_reps/rep2/pr1/H9_Fucci_SG2M_D2_S34_L004_R1_001.trim.PE2SE.nodup.pr1.tn5.pf.pval0.1.gappedPeak.gz | sort -grk14 | head -n 500000 | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated/out/peak/macs2/pseudo_reps/rep2/pr1/H9_Fucci_SG2M_D2_S34_L004_R1_001.trim.PE2SE.nodup.pr1.tn5.pf.pval0.1.500K.gappedPeak.gz

# SYS command. line 51

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
