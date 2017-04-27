#!/bin/bash -e

cd '/srv/scratch/annashch/sundari'

# SYS command. line 172

 if [[ -f $(which activate) ]]; then source activate bds_atac; fi;  export PATH=/srv/scratch/annashch/bds_atac/.:/srv/scratch/annashch/bds_atac/modules:/srv/scratch/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds;

# SYS command. line 183

 samtools view -F 1804 -f 2 -q 30 -u /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.bam | samtools sort -n - /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark

# SYS command. line 190

 samtools fixmate -r /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam.fixmate.bam

# SYS command. line 191

 samtools view -F 1804 -f 2 -u /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam.fixmate.bam | samtools sort - /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt

# SYS command. line 192

 rm /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam.fixmate.bam

# SYS command. line 196

 export _JAVA_OPTIONS="-Xms256M -Xmx4G -XX:ParallelGCThreads=1"

# SYS command. line 199

 if [ -f ${PICARDROOT}/MarkDuplicates.jar ]; then \
			java -Xmx4G -jar ${PICARDROOT}/MarkDuplicates.jar \
				INPUT="/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam" OUTPUT="/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam" \
				METRICS_FILE="/srv/scratch/annashch/sundari/output/qc/rep1/160429-BW-3_R1.trim.PE2SE.dup.qc" VALIDATION_STRINGENCY=LENIENT \
				ASSUME_SORTED=true REMOVE_DUPLICATES=false; \
			else \
			java -Xmx4G -jar ${PICARDROOT}/picard.jar MarkDuplicates \
				INPUT="/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam" OUTPUT="/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam" \
				METRICS_FILE="/srv/scratch/annashch/sundari/output/qc/rep1/160429-BW-3_R1.trim.PE2SE.dup.qc" VALIDATION_STRINGENCY=LENIENT \
				ASSUME_SORTED=true REMOVE_DUPLICATES=false; \
			fi

# SYS command. line 217

 mv /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam

# SYS command. line 219

 samtools view -F 1804 -f 2 -b /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam > /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bam

# SYS command. line 221

 samtools index /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bam

# SYS command. line 223

 if [ "/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bam.bai" != "/srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bai" ]; then \
			cp /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bam.bai /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bai; \
			fi

# SYS command. line 227

 samtools flagstat /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.nodup.bam > /srv/scratch/annashch/sundari/output/qc/rep1/160429-BW-3_R1.trim.PE2SE.nodup.flagstat.qc

# SYS command. line 238

 samtools sort -n /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam.tmp

# SYS command. line 239

 bedtools bamtobed -bedpe -i /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam.tmp.bam | \
			awk 'BEGIN{OFS="\t"}{print $1,$2,$4,$6,$9,$10}' | \
			grep -v 'chrM' | sort | uniq -c | \
			awk 'BEGIN{mt=0;m0=0;m1=0;m2=0} ($1==1){m1=m1+1} ($1==2){m2=m2+1} {m0=m0+1} {mt=mt+$1} END{printf "%d\t%d\t%d\t%d\t%f\t%f\t%f\n",mt,m0,m1,m2,m0/mt,m1/m0,m1/m2}' > /srv/scratch/annashch/sundari/output/qc/rep1/160429-BW-3_R1.trim.PE2SE.nodup.pbc.qc

# SYS command. line 243

 rm /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam.tmp.bam

# SYS command. line 245

 rm -f /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.filt.bam

# SYS command. line 246

 rm -f /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-3_R1.trim.PE2SE.dupmark.bam
