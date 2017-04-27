#intersection of ATAC-seq, CHIP-seq, and RNA-seq 
python intersect_heatmap_inputs.py --heatmap_inputs atacseq_heatmap_inputs.txt  chipseq_heatmap_inputs.txt  rnaseq_heatmap_inputs.txt --gene_column 2 2 1 --outf heatmap_inputs_intersection.txt

#intersection of ATAC-seq and RNA-seq 
#python intersect_heatmap_inputs.py --heatmap_inputs atacseq_heatmap_inputs.txt   rnaseq_heatmap_inputs.txt --gene_column 2 1 --outf heatmap_inputs_intersection_ATAC_RNASEQ.txt

