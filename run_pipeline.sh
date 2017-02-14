#controls
#bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1_1 /mnt/lab_data/kundaje/projects/sundari/160429-BW-1_R1.fastq -fastq1_2 /mnt/lab_data/kundaje/projects/sundari/160429-BW-1_R2.fastq -fastq2_1 /mnt/lab_data/kundaje/projects/sundari/160429-BW-2_R1.fastq -fastq2_2 /mnt/lab_data/kundaje/projects/sundari/160429-BW-2_R2.fastq  -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -par_lvl 5

#DMSO treated 
#bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1_1 /mnt/lab_data/kundaje/projects/sundari/160429-BW-3_R1.fastq -fastq1_2 /mnt/lab_data/kundaje/projects/sundari/160429-BW-3_R2.fastq -fastq2_1 /mnt/lab_data/kundaje/projects/sundari/160429-BW-4_R1.fastq -fastq2_2 /mnt/lab_data/kundaje/projects/sundari/160429-BW-4_R2.fastq  -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -par_lvl 5


#TAKE 2 -- reads have been trimmed successfully,  libncurses bug has been fixed. 
#controls
#bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1_1 output/align/rep1/160429-BW-1_R1.trim.fastq.gz -fastq1_2 output/align/rep1/160429-BW-1_R2.trim.fastq.gz -fastq2_1 output/align/rep2/160429-BW-2_R1.trim.fastq.gz -fastq2_2 output/align/rep2/160429-BW-2_R2.trim.fastq.gz  -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -par_lvl 5 -trimmed_fastq -nth_bwt2 8


#DMSO treated 
#bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1_1 output/align/rep1/160429-BW-3_R1.trim.fastq.gz -fastq1_2 output/align/rep1/160429-BW-3_R2.trim.fastq.gz -fastq2_1 output/align/rep2/160429-BW-4_R1.trim.fastq.gz -fastq2_2 output/align/rep2/160429-BW-4_R2.trim.fastq.gz  -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -trimmed_fastq -nth_bwt2 8

bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1_1 output/align/rep1/160429-BW-3_R1.trim.fastq.gz -fastq1_2 output/align/rep1/160429-BW-3_R2.trim.fastq.gz -fastq2_1 output/align/rep2/160429-BW-4_R1.trim.fastq.gz -fastq2_2 output/align/rep2/160429-BW-4_R2.trim.fastq.gz  -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -trimmed_fastq -nth_bwt2 8


#bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/output -fastq1 output/align/rep1/160429-BW-3_R1.trim.fastq.gz -fastq2 output/align/rep1/160429-BW-3_R2.trim.fastq.gz -species hg19  -align  -trimmed_fastq -nth_bwt2 16

