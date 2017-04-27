#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated'

# SYS command. line 543

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 546

 bedtools bamtobed -bedpe -mate1 -i /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.nmsrt.bam | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.bedpe.gz

# SYS command. line 548

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
