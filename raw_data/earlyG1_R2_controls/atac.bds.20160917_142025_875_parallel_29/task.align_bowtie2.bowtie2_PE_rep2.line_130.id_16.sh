#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls'

# SYS command. line 132

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 134

 bowtie2  -X2000 --mm --threads 2 -x /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/bwt2_idx/ENCODEHg19_male \
			-1 /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R1_001.trim.fastq.gz -2 /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R2_001.trim.fastq.gz 2>/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/qc/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R1_001.trim.PE2SE.align.log | \
			samtools view -Su /dev/stdin | sambamba sort -t 1 /dev/stdin -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_controls/out/align/rep2/H9_Fucci_earlyG1_R2_C2_S36_L005_R1_001.trim.PE2SE.bam

# SYS command. line 138

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
