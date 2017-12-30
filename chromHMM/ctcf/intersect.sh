bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b earlyG1.up.sorted.extraflank | cut -f4,10,11,12,13 > earlyG1.up.annotation
bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b earlyG1.down.sorted.extraflank | cut -f4,10,11,12,13 > earlyG1.down.annotation 
bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b lateG1.up.sorted.extraflank | cut -f4,10,11,12,13 > lateG1.up.annotation
bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b lateG1.down.sorted.extraflank | cut -f4,10,11,12,13 > lateG1.down.annotation 
bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b SG2M.up.sorted.extraflank | cut -f4,10,11,12,13 > SG2M.up.annotation
bedtools intersect -wo -a wgEncodeBroadHmmH1hescHMM.bed -b SG2M.down.sorted.extraflank | cut -f4,10,11,12,13 > SG2M.down.annotation 
