#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated'

# SYS command. line 436

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 439

 sambamba sort -t 1 -n /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.bam -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.nmsrt.bam

# SYS command. line 441

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
