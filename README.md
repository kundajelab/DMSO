# DMSO
Code for DMSO data analysis


#CURRENT WORKFLOWS

* ATAC-seq
 1. data pre-processing and fold-change matrix generation: create_atac_fc_merged.sh
 2. analysis with limma voom & SVA : limma_atac.R
 3. analysis with DESEQ2 & SVA:
    a. remove surrogate variables that do not correlate with cell-cycle-point, dmso treatment, or density: pca_heatmap/sva_analysis.R
    b. getDiff_multifactor_atacseq.r

* RNA-seq
 1. create input matrix by extracting 'expected_count' column from all RNA-seq samples.
 2. analysis with limma voom  & SVA: limma_rna.R
 3. analysis with DESEQ2 & SVA:
    a. remove surrogate variables that do not correlate with cell-cycle-point, dmso treatment, or density: pca_heatmap/sva_analysis_rnaseq.R
    b. getDiff_multifactor_rnaseq.r


* CHIP-seq
 1. data pre-processing and fold-change matrix generation: generate_chipseq_peakset.sh
 2. analysis with limma voom: limma_chip.R



