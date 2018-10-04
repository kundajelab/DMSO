#for task in earlyG1.down.vs.alldiffpeaks homer.diff_vs_called_peaks lateG1.down.vs.alldiffpeaks SG2M.down.vs.alldiffpeaks earlyG1.up.vs.alldiffpeaks homer.diff_vs_hg19 lateG1.up.vs.alldiffpeaks SG2M.up.vs.alldiffpeaks
#do
#    for i in `seq 1 15`
#    do
#	cat $task/homerResults/motif$i.motif | grep ">" >> top15.$task
#    done
#done

python aggregate_homer_hits.py --tasks earlyG1.down.vs.alldiffpeaks  lateG1.down.vs.alldiffpeaks SG2M.down.vs.alldiffpeaks earlyG1.up.vs.alldiffpeaks lateG1.up.vs.alldiffpeaks SG2M.up.vs.alldiffpeaks homer.diff_vs_called_peaks homer.diff_vs_hg19  \
       --task_names_preferred earlyG1.down lateG1.down SG2M.down earlyG1.up lateG1.up SG2M.up differentialVScalled differentialVShg19 \
       --outf homer.summary \
       --log_pval_col 3 \
       --motif_name_col 1

