#!/bin/bash -e

cd '/srv/scratch/annashch/sundari'

# SYS command. line 130

 if [[ -f $(which activate) ]]; then source activate bds_atac; fi;  export PATH=/srv/scratch/annashch/bds_atac/.:/srv/scratch/annashch/bds_atac/modules:/srv/scratch/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds;

# SYS command. line 134

 bowtie2 -X2000 --mm --threads 2 -x /mnt/data/annotations/indexes/bowtie2_indexes/bowtie2/ENCODEHg19_male \
			-1 /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-1_R1.trim.fastq.gz -2 /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-1_R2.trim.fastq.gz 2>/srv/scratch/annashch/sundari/output/qc/rep1/160429-BW-1_R1.trim.PE2SE.align.log | samtools view -bS - | samtools sort - /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-1_R1.trim.PE2SE

# SYS command. line 137

 samtools index /srv/scratch/annashch/sundari/output/align/rep1/160429-BW-1_R1.trim.PE2SE.bam
