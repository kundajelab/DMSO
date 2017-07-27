#python subset_tads.py --permutation_result atac_permutations \
#       --observed_result differential_atac_peak_tad_distribution.txt \
#       --out_prefix atac_summary

python subset_tads.py --permutation_result gene_permutations \
       --observed_result differential_expressed_gene_tad_distribution.txt \
       --out_prefix gene_summary

