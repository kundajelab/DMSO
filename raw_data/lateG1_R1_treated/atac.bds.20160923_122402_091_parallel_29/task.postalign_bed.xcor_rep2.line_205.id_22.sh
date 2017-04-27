#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated'

# SYS command. line 207

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 210

 if [[ $(which run_spp_nodups.R 2> /dev/null | wc -l || echo) == "1" ]]; then RUN_SPP=$(which run_spp_nodups.R); \
		    else RUN_SPP=$(which run_spp.R); \
		    fi

# SYS command. line 216

 Rscript ${RUN_SPP} -rf \
			-c=/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.tagAlign.gz -p=2 \
			-filtchr=chrM -savp=/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.plot.pdf -out=/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.qc -speak=0

# SYS command. line 219

 sed -r 's/,[^\t]+//g' /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.qc > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.qc.tmp

# SYS command. line 220

 mv /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.qc.tmp /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/qc/rep2/H9_Fucci_LateG1_D2_S30_L004_R1_001.trim.PE2SE.nodup.25M.cc.qc

# SYS command. line 222

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
