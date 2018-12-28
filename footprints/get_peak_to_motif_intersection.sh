for motif in pou5f1 smad3 sox8 tead1
do
    bedtools intersect -a $motif.hg19.bed -b all.diffpeaks.bed > $motif.intersection.bed
    #pad motif to 200 bp
    python ~/anna_utils/seq_utils/pad.py --input_bed $motif.intersection.bed --desired_length 200 --output_bed $motif.intersection.padded.bed --chromsizes /mnt/data/annotations/by_release/hg19.GRCh37/hg19.chrom.sizes
done

