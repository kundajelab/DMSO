#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls'

# SYS command. line 292

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 295

 nlines=$( zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/rep2/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.bedpe.gz | wc -l )

# SYS command. line 296

 nlines=$(( (nlines + 1) / 2 ))

# SYS command. line 300

 zcat /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/rep2/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.bedpe.gz | shuf | split -d -l $((nlines)) - /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.  

# SYS command. line 303

 awk 'BEGIN{OFS="\t"}{printf "%s\t%s\t%s\tN\t1000\t%s\n%s\t%s\t%s\tN\t1000\t%s\n",$1,$2,$3,$9,$4,$5,$6,$10}' "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.00" | \
			gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.pr1.tagAlign.gz

# SYS command. line 305

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.00

# SYS command. line 306

 awk 'BEGIN{OFS="\t"}{printf "%s\t%s\t%s\tN\t1000\t%s\n%s\t%s\t%s\tN\t1000\t%s\n",$1,$2,$3,$9,$4,$5,$6,$10}' "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.01" | \
			gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr2/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.pr2.tagAlign.gz

# SYS command. line 308

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/align/pseudo_reps/rep2/pr1/H9_Fucci_LateG1_R2_C2_S40_L005_R1_001.trim.PE2SE.nodup.01

# SYS command. line 310

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
