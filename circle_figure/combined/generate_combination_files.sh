python generate_combination_files.py --pathway_to_gene earlyG1.up.table.txt \
       --gene_to_peak predicted_impact_scores.earlyG1.up.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation earlyG1.up.chrom_states.bed.filtered \
       --outf earlyG1.up.combined.txt \
       --label earlyG1.up


python generate_combination_files.py --pathway_to_gene earlyG1.down.table.txt \
       --gene_to_peak predicted_impact_scores.earlyG1.down.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation earlyG1.down.chrom_states.bed.filtered \
       --outf earlyG1.down.combined.txt \
       --label earlyG1.down 

python generate_combination_files.py --pathway_to_gene lateG1.up.table.txt \
       --gene_to_peak predicted_impact_scores.lateG1.up.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation lateG1.up.chrom_states.bed.filtered \
       --outf lateG1.up.combined.txt \
       --label lateG1.up


python generate_combination_files.py --pathway_to_gene lateG1.down.table.txt \
       --gene_to_peak predicted_impact_scores.lateG1.down.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation lateG1.down.chrom_states.bed.filtered \
       --outf lateG1.down.combined.txt \
       --label lateG1.down 


python generate_combination_files.py --pathway_to_gene SG2M.up.table.txt \
       --gene_to_peak predicted_impact_scores.SG2M.up.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation SG2M.up.chrom_states.bed.filtered \
       --outf SG2M.up.combined.txt \
       --label SG2M.up 


python generate_combination_files.py --pathway_to_gene SG2M.down.table.txt \
       --gene_to_peak predicted_impact_scores.SG2M.down.motifs.txt \
       --chrom_hmm_state_map state_map.txt \
       --chrom_hmm_annotation SG2M.down.chrom_states.bed.filtered \
       --outf SG2M.down.combined.txt \
       --label SG2M.down


