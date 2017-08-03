#All ATAC-seq peaks 
python get_peak_distribution_in_tads.py --tads all.tads.bed --peaks ../atacseq_merged.peaks.bed --outf all_atac_peak_tad_distribution.txt

#Differential ATAC-seq peaks 
python get_peak_distribution_in_tads.py --tads all.tads.bed --peaks differential_atac_peaks.bed --outf differential_atac_peak_tad_distribution.txt

#All expressed genes
python get_peak_distribution_in_tads.py --tads all.tads.bed --peaks expressed_genes.bed --outf all_expressed_gen_tad_distribution.txt 

#Differentially expressed gene
python get_peak_distribution_in_tads.py --tads all.tads.bed --peaks differential_genes.bed --outf differential_expressed_gene_tad_distribution.txt 
