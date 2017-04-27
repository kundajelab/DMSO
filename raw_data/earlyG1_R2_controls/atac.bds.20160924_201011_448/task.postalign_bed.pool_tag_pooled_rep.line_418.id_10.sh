#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls'

# SYS command. line 420

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 422

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/rep1/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5.tagAlign.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R1_001.trim.PE2SE.nodup.tn5.tagAlign.gz  | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/pooled_rep/H9_Fucci_earlyG1_R2_C1_S35_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.tagAlign.gz

# SYS command. line 424

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
