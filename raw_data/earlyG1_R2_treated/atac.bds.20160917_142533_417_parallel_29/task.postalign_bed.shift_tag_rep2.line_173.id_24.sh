#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated'

# SYS command. line 175

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 177

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.tagAlign.gz | awk -F $'\t' 'BEGIN {OFS = FS}{ if ($6 == "+") {$2 = $2 + 4} else if ($6 == "-") {$3 = $3 - 5} print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.tn5.tagAlign.gz

# SYS command. line 179

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
