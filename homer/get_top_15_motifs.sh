for task in homer.earlyG1.down  homer.earlyG1.up  homer.lateG1.down  homer.lateG1.up  homer.SG2M.down  homer.SG2M.up
do
    for i in `seq 1 15`
    do
	cat $task/homerResults/motif$i.motif | grep ">" >> top15.$task
    done
done

python aggregate_homer_hits.py --tasks homer.earlyG1.down  homer.earlyG1.up homer.lateG1.down  homer.lateG1.up  homer.SG2M.down  homer.SG2M.up\
       --task_names_preferred earlyG1.down earlyG1.up lateG1.down lateG1.up SG2M.down SG2M.up \
       --outf homer.summary \
       --log_pval_col 3 \
       --motif_name_col 1
