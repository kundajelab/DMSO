python perform_permutation_test.py --peaks ../atacseq_merged.peaks.bed \
       --num_to_sample 660 \
       --tads all.tads.bed \
       --outf atac_permutations

python perform_permutation_test.py --peaks expressed_genes.bed \
       --num_to_sample 3784 \
       --tads all.tads.bed \
       --outf gene_permutations
