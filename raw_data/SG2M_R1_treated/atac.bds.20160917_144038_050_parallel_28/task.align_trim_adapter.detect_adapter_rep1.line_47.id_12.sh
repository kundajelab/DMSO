#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated'

# SYS command. line 49

 if [[ -f $(which conda) && $(conda env list | grep bds_atac_py3 | wc -l) != "0" ]]; then source activate bds_atac_py3; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 51

 python3 $(which detect_adapter.py) /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated/H9_Fucci_SG2M_D1_S33_L004_R2_001.fastq.gz > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_treated/out/qc/rep1/H9_Fucci_SG2M_D1_S33_L004_R2_001.adapter.txt

# SYS command. line 53

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
