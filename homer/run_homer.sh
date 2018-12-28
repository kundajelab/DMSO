for sample in  earlyG1.down  earlyG1.up  lateG1.down  lateG1.up  SG2M.down  SG2M.up
do
    findMotifsGenome.pl $sample.bed hg19 homer.$sample -bg background.bed &
done
