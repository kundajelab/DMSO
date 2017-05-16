#generate tpm from counts 
python calculate_tpm_atacseq.py --counts /srv/scratch/annashch/dmso/counts/counts.atac.lowdensity.cellcycle\
       --peaks  /srv/scratch/annashch/dmso/merged_peaks/ppr.merged.bed\
       --outf /srv/scratch/annashch/dmso/counts/counts.atac.lowdensity.cellcycle.tpm
