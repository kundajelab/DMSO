#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated'

# SYS command. line 219

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 235

 if [[ 0 > 0 ]]; then \
				samtools view -F 524 -f 2 -u /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.bam | \
				sambamba sort -t 1 -n /dev/stdin -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam; \
				samtools view -h /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam | \
				$(which assign_multimappers.py) -k 0 --paired-end | \
				samtools fixmate -r /dev/stdin /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam; \
			    else \
			    	samtools view -F 1804 -f 2 -q 30 -u /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.bam | \
			    	sambamba sort -t 1 -n /dev/stdin -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam; \
			        samtools fixmate -r /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam; \
			    fi

# SYS command. line 247

 samtools view -F 1804 -f 2 -u /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam | sambamba sort -t 1 /dev/stdin -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.filt.bam

# SYS command. line 249

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam

# SYS command. line 250

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dupmark.bam

# SYS command. line 252

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
