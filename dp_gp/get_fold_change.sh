python get_fold_change.py --normalized_cpm new_RSEM.tpm.corrected.averagedrep.diff \
       --name_col 0\
       --numer 4 5 6\
       --denom 1 2 3\
       --outf fold_change_cpm_genes.dpgp.input.tsv
#python get_fold_change.py --normalized_cpm all_differential_peaks.dpgp.input.tsv \
#       --name_col 0\
#       --numer 4 5 6\
#       --denom 1 2 3\
#       --outf fold_change_cpm_peaks.dpgp.input.tsv
