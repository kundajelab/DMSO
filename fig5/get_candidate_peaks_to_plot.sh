#only consider peak/gene associations where peak is < 10kb from TSS

#(filtered in EXCEL) 
#the peak must be a gene that is differentially expressed in one of the conditions
grep -w -f ../diff_gene_list/earlyG1.down h3k27me3_down.nearest.tss.bed > h3k27me3_down_earlyG1.down
grep -w -f ../diff_gene_list/earlyG1.up h3k27me3_down.nearest.tss.bed > h3k27me3_down_earlyG1.up
grep -w -f ../diff_gene_list/lateG1.down h3k27me3_down.nearest.tss.bed > h3k27me3_down_lateG1.down
grep -w -f ../diff_gene_list/lateG1.up h3k27me3_down.nearest.tss.bed > h3k27me3_down_lateG1.up
grep -w -f ../diff_gene_list/SG2M.down h3k27me3_down.nearest.tss.bed > h3k27me3_down_SG2M.down
grep -w -f ../diff_gene_list/SG2M.up h3k27me3_down.nearest.tss.bed > h3k27me3_down_SG2M.up

#how many of the genes are along one of the key pathways?
