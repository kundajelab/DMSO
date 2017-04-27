#TAKE 2 -- reads have been trimmed successfully,  libncurses bug has been fixed. 
#dmsox
bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/dmso/output_dmso  -bam1 output_dmso/align/rep1/160429-BW-3_R1.trim.PE2SE.bam  -bam2 output_dmso/align/rep2/160429-BW-4_R1.trim.PE2SE.bam -input bam   -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -par_lvl 5 -trimmed_fastq 

