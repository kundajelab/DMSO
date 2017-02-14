python limma_to_hammock.py  --voom_file atac_differential_earlyg1_dmso_control.tsv --output_file atac_differential_earlyg1_dmso_control.hammock --coord_column Chrom_Start_End
python limma_to_hammock.py  --voom_file atac_differential_lateg1_dmso_control.tsv --output_file atac_differential_lateg1_dmso_control.hammock --coord_column Chrom_Start_End
python limma_to_hammock.py  --voom_file atac_differential_sg2m_dmso_control.tsv --output_file atac_differential_sg2m_dmso_control.hammock --coord_column Chrom_Start_End


python limma_to_hammock.py  --voom_file rna_differential_earlyg1_dmso_control.tsv --output_file rna_differential_earlyg1_dmso_control.hammock --coord_column Chrom_Start_End
python limma_to_hammock.py  --voom_file rna_differential_lateg1_dmso_control.tsv --output_file rna_differential_lateg1_dmso_control.hammock --coord_column Chrom_Start_End
python limma_to_hammock.py  --voom_file rna_differential_sg2m_dmso_control.tsv --output_file rna_differential_sg2m_dmso_control.hammock --coord_column Chrom_Start_End

