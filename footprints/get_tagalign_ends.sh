for sample in earlyG1.controls earlyG1.dmso lateG1.controls lateG1.dmso SG2M.controls SG2M.dmso
do      
    python contract_bed.py --inputf $sample.pos  --strand forward --outf $sample.pos.5p.bed &
    python contract_bed.py --inputf $sample.neg  --strand reverse --outf $sample.neg.3p.bed &
done
