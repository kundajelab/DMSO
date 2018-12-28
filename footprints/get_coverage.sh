for motif in pou5f1 smad3 sox8 tead1
do
    for sample in earlyG1.controls lateG1.controls SG2M.controls earlyG1.dmso lateG1.dmso SG2M.dmso
    do
    # Ap1 positive NEMO
    bedtools coverage -a $motif.intersection.padded.bed -b $sample.pos.5p.bed -d  > $sample.$motif.pos.cuts.bed &

    #Ap1 negative NEMO
    bedtools coverage -a $motif.intersection.padded.bed -b $sample.neg.3p.bed -d  > $sample.$motif.neg.cuts.bed &
    done
done
