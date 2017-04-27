python summarize_model_comparisons.py --models model_comparison_earlyg1_dmso_control  model_comparison_earlyg1_sg2m_dmso    model_comparison_lateg1_earlyg1_control  model_comparison_sg2m_dmso_control model_comparison_sg2m_lateg1_dmso model_comparison_earlyg1_sg2m_control  model_comparison_lateg1_dmso_control  model_comparison_lateg1_earlyg1_dmso model_comparison_sg2m_lateg1_control --gene_sets /srv/scratch/annashch/dmso/cell_adhesion_gene_list.csv /srv/scratch/annashch/dmso/differentiation_genes_jingling/differentiation_genes.csv --task_names DESEQ2:Model+SVASEQ DESEQ2:Model+exp\(SVASEQ\) LIMMA\(asinh\(TPM\)\):Model+SVA LIMMA\(asinh\(TPM\)\):Model+exp\(SVA\) LIMMA\(asinh\(TPM\)-SVA\):Model LIMMA\(asinh\(TPM\)-exp\(SVA\)\) LIMMA:Model+SVASEQ LIMMA:Model+exp\(SVASEQ\) LIMMA\(rlog\(counts\)-SVA\) LIMMA\(rlog\(counts\)-exp\(SVA\)\) LIMMA\(rlog\(counts\)\):Model+exp\(SVA\) LIMMA\(rlog\(counts\)\):Model+SVA  --outf model_summary.txt
