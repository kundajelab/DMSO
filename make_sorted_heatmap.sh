#ATAC-seq
python make_sorted_heatmap.py --differential atac_differential_earlyg1_dmso_control.tsv  atac_differential_lateg1_dmso_control.tsv    atac_differential_sg2m_dmso_control.tsv   --normalized_fc atac_corrected.csv --peak_to_gene atacseq_merged.peaks.togenes.bed --out atacseq_heatmap_inputs.txt

#RNA-seq
python make_sorted_heatmap.py --differential rna_differential_earlyg1_dmso_control.tsv  rna_differential_lateg1_dmso_control.tsv    rna_differential_sg2m_dmso_control.tsv   --normalized_fc rsem.fpkm.csv --out rnaseq_heatmap_inputs.txt

#Chip-seq 
python make_sorted_heatmap.py --differential chipseq_differential_h3k27ac_dmso_control.tsv   chipseq_differential_h3k27me3_dmso_control.tsv  chipseq_differential_h3k4me3_dmso_control.tsv --normalized_fc chipseq_normalized.tsv --peak_to_gene chipseq_merged.peaks.togenes.bed --out chipseq_heatmap_inputs.txt


