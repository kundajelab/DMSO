for fname in earlyG1.down.bed lateG1.down.bed SG2M.down.bed earlyG1.up.bed lateG1.up.bed SG2M.up.bed
do
    bedtools intersect -a E008_15_coreMarks_dense.bed -b $fname > $fname.intersection.bed
done
