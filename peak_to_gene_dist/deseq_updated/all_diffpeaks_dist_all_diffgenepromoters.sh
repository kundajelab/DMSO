#generate CDF for distance from differential peak to nearest differential gene
#generate CDF for distance from differential gene to nearest differential peak

#get full list of differential peaks
cat *atac.tsv | cut -f1 | sort |uniq | sed --expression "s/\_/\t/g"| grep -v "baseMean" | bedtools sort -i stdin | uniq  > all.diffpeaks.tsv

#get full list of differential genes
#get the promoter coordinates of the differential genes
cat *rna.tsv | cut -f1 | sort |uniq | cut -f1 -d '_' | grep -f - -w ../hg19.5kb.promters.bed  | bedtools sort -i stdin | uniq > all.diffgene.promoters.tsv

#run bedtools closest for diff peaks
bedtools closest -a all.diffpeaks.tsv -b all.diffgene.promoters.tsv -d -t first > peaks.closest.bed 

#run bedtools closest for diff genes
bedtools closest -a all.diffgene.promoters.tsv  -b all.diffpeaks.tsv -d -t first > genes.closest.bed 

# generate CDF plots

