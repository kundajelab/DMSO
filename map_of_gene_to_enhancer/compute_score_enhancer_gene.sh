#NOTE atac_limma_column should be 0-indexed
#CHIP-seq RPM are from h3k27ac_bdg file

#earlyG1, treated 
#python compute_score_enhancer_gene.py --gene_list earlyG1.up\
#       --promoter_to_gene refGene_hg19_TSS.bed\
#       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
#       --atac_limma_file atac_differential_peaks.txt\
#       --atac_limma_column 3\
#       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
#       --atac_rpm_file atac.rpm.counts\
#       --atac_rpm_column 4\
#       --outf predicted_impact_scores.earlyG1.up.tsv
#       --runall


python compute_score_enhancer_gene.py --gene_list earlyG1.down\
       --promoter_to_gene refGene_hg19_TSS.bed\
       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
       --atac_limma_file atac_differential_peaks.txt\
       --atac_limma_column 3\
       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
       --atac_rpm_file atac.rpm.counts\
       --atac_rpm_column 4\
       --outf predicted_impact_scores.earlyG1.down.tsv\
       --runall
echo "earlyG1.down"

python compute_score_enhancer_gene.py --gene_list lateG1.down\
       --promoter_to_gene refGene_hg19_TSS.bed\
       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
       --atac_limma_file atac_differential_peaks.txt\
       --atac_limma_column 4\
       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
       --atac_rpm_file atac.rpm.counts\
       --atac_rpm_column 6\
       --outf predicted_impact_scores.lateG1.up.tsv\
       --runall
echo "lateG1.up"

python compute_score_enhancer_gene.py --gene_list lateG1.up\
       --promoter_to_gene refGene_hg19_TSS.bed\
       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
       --atac_limma_file atac_differential_peaks.txt\
       --atac_limma_column 4\
       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
       --atac_rpm_file atac.rpm.counts\
       --atac_rpm_column 6\
       --outf predicted_impact_scores.lateG1.down.tsv\
       --runall
echo "lateG1.down"

python compute_score_enhancer_gene.py --gene_list SG2M.up\
       --promoter_to_gene refGene_hg19_TSS.bed\
       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
       --atac_limma_file atac_differential_peaks.txt\
       --atac_limma_column 5\
       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
       --atac_rpm_file atac.rpm.counts\
       --atac_rpm_column 8\
       --outf predicted_impact_scores.SG2M.up.tsv\
       --runall
echo "SG2M.up"

python compute_score_enhancer_gene.py --gene_list SG2M.down\
       --promoter_to_gene refGene_hg19_TSS.bed\
       --h3k27ac_bdg_file dmso1.nodup_pooled.tagAlign_x_wce_for_dmso1.nodup_wce_for_dmso3.nodup.tagAlign_treat_pileup.bdg\
       --atac_limma_file atac_differential_peaks.txt\
       --atac_limma_column 5\
       --nij_hic_base_dir /srv/scratch/annashch/dmso/tad_regions/hES/nij\
       --atac_rpm_file atac.rpm.counts\
       --atac_rpm_column 8\
       --outf predicted_impact_scores.SG2M.down.tsv\
       --runall
echo "SG2M.down"
