#with the consensus CTCF motif 
#python condense_motif_summaries.py --motif_hits atacseq_merged.consensus_1_1e-05 earlyG1.down.consensus_1_1e-05 earlyG1.up.consensus_1_1e-05 lateG1.down.consensus_1_1e-05 lateG1.up.consensus_1_1e-05 SG2M.down.consensus_1_1e-05 SG2M.up.consensus_1_1e-05 \
#       --loop_dir looplists \
#       --motif_name_to_sequence /srv/scratch/annashch/hocomoco_scan/consensus_dict_CTCF.txt \
#       --outf consensus_summary

#with full set of CTCF motifs 
python condense_motif_summaries.py --motif_hits atacseq_merged_1_1e-05 earlyG1.down_1_1e-05 earlyG1.up_1_1e-05 lateG1.down_1_1e-05 lateG1.up_1_1e-05 SG2M.down_1_1e-05 SG2M.up_1_1e-05 \
       --loop_dir looplists \
       --motif_name_to_sequence /srv/scratch/annashch/hocomoco_scan/consensus_dict_CTCF.txt \
       --outf all_summary

#python condense_motif_summaries.py --motif_hits  earlyG1.down_1_1e-05 earlyG1.up_1_1e-05 lateG1.down_1_1e-05 lateG1.up_1_1e-05 SG2M.down_1_1e-05 SG2M.up_1_1e-05 \
#       --loop_dir looplists \
#       --motif_name_to_sequence /srv/scratch/annashch/hocomoco_scan/consensus_dict_CTCF.txt \
#       --outf all_summary
