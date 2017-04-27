
#TAKE 2 -- reads have been trimmed successfully,  libncurses bug has been fixed. 
#controls
bds /srv/scratch/annashch/bds_atac/atac.bds -out_dir /srv/scratch/annashch/sundari/controls/output_controls -bam1 output_controls/align/rep1/160429-BW-1_R1.trim.PE2SE.srt.bam -bam2 output_controls/align/rep2/160429-BW-2_R1.trim.PE2SE.srt.bam -input bam   -species hg19  -pseudorep -idr -blacklist /srv/scratch/annashch/refs/wgEncodeDacMapabilityConsensusExcludable.bed -par_lvl 5 -trimmed_fastq 

