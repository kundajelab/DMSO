#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated'

# SYS command. line 282

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 289

 samtools view -F 1804 -f 2 -b /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.dupmark.bam > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.bam

# SYS command. line 291

 sambamba index -t 2 /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.bam

# SYS command. line 293

 sambamba flagstat -t 2 /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.bam > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/qc/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.flagstat.qc

# SYS command. line 304

 sambamba sort -t 2 -n /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.dupmark.bam -o /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.dupmark.bam.tmp.bam

# SYS command. line 306

 bedtools bamtobed -bedpe -i /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.dupmark.bam.tmp.bam | \
				awk 'BEGIN{OFS="\t"}{print $1,$2,$4,$6,$9,$10}' | \
				grep -v 'chrM' | sort | uniq -c | \
				awk 'BEGIN{mt=0;m0=0;m1=0;m2=0} ($1==1){m1=m1+1} ($1==2){m2=m2+1} {m0=m0+1} {mt=mt+$1} END{m1_m2=-1.0; if(m2>0) m1_m2=m1/m2; printf "%d\t%d\t%d\t%d\t%f\t%f\t%f\n",mt,m0,m1,m2,m0/mt,m1/m0,m1_m2}' > /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/qc/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.nodup.pbc.qc

# SYS command. line 310

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R2_treated/out/align/rep2/H9_Fucci_earlyG1_R2_D2_S38_L005_R1_001.trim.PE2SE.dupmark.bam.tmp.bam

# SYS command. line 312

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
