for f in earlyG1.down.chrom_states.bed  earlyG1.up.chrom_states.bed  lateG1.down.chrom_states.bed  lateG1.up.chrom_states.bed  SG2M.down.chrom_states.bed  SG2M.up.chrom_states.bed
do
    python peak_to_chromhmm.py --intersection_file $f --outf $f.filtered 
done

