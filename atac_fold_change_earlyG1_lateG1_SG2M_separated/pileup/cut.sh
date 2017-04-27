cut -f2 -d '|' earlyG1_R2_controls.rep1.idr > 1
cut -f2 -d '|' earlyG1_R2_controls.rep2.idr > 2
cut -f2 -d '|' earlyG1_R2_treated.rep1.idr > 3
cut -f2 -d '|' earlyG1_R2_treated.rep2.idr > 4
cut -f2 -d '|' lateG1_R2_controls.rep1.idr > 5
cut -f2 -d '|' lateG1_R2_controls.rep2.idr > 6
cut -f2 -d '|' lateG1_R2_treated.rep1.idr > 7
cut -f2 -d '|' lateG1_R2_treated.rep2.idr > 8
cut -f2 -d '|' SG2M_R2_controls.rep1.idr > 9
cut -f2 -d '|' SG2M_R2_controls.rep2.idr > 10
cut -f2 -d '|' SG2M_R2_treated.rep1.idr > 11
cut -f2 -d '|' SG2M_R2_treated.rep2.idr > 12
paste 1 2 3 4 5 6 7 8 9 10 11 12 > macs.fc.ld.atac.tab

