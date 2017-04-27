#!/bin/bash -e

cd '/srv/scratch/annashch/dmso/earlyG1_R1_controls'

# SYS command. line 219

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/srv/scratch/annashch/bds_atac/.:/srv/scratch/annashch/bds_atac/modules:/srv/scratch/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 10 $$

# SYS command. line 235

 if [[ 0 > 0 ]]; then \
				samtools view -F 524 -f 2 -u /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.bam | \
				sambamba sort -t 2 -n /dev/stdin -o /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam; \
				samtools view -h /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam | \
				$(which assign_multimappers.py) -k 0 --paired-end | \
				samtools fixmate -r /dev/stdin /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam; \
			    else \
			    	samtools view -F 1804 -f 2 -q 30 -u /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.bam | \
			    	sambamba sort -t 2 -n /dev/stdin -o /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam; \
			        samtools fixmate -r /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam; \
			    fi

# SYS command. line 247

 samtools view -F 1804 -f 2 -u /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam | sambamba sort -t 2 /dev/stdin -o /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.filt.bam

# SYS command. line 249

 rm -f /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam.fixmate.bam

# SYS command. line 250

 rm -f /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/align/rep2/H9_Fucci_earlyG1_C2_S24_L004_R1_001.trim.PE2SE.dupmark.bam

# SYS command. line 252

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
