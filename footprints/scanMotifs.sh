for motif in pou2f1 #smad3 sox8 tead1
do
    scanMotifGenomeWide.pl $motif.motif hg19 -p 10 -bed > $motif.hg19.bed  &
done
