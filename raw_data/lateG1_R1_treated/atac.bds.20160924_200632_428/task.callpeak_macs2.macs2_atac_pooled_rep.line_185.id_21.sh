#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated'

# SYS command. line 187

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 188

 export LC_COLLATE=C

# SYS command. line 190

 macs2 callpeak \
			-t /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.tagAlign.gz -f BED -n "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf" -g "hs" -p 0.01 \
			--nomodel --shift -75 --extsize 150 --broad --keep-dup all

# SYS command. line 195

 sort -k 8gr,8gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.broadPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.broadPeak.gz

# SYS command. line 196

 sort -k 14gr,14gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.gappedPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.gappedPeak.gz

# SYS command. line 197

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.broadPeak

# SYS command. line 198

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.gappedPeak

# SYS command. line 200

 macs2 callpeak \
			-t /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.tagAlign.gz -f BED -n "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf" -g "hs" -p 0.01 \
			--nomodel --shift -75 --extsize 150 -B --SPMR --keep-dup all --call-summits

# SYS command. line 205

 sort -k 8gr,8gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.narrowPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.narrowPeak.gz

# SYS command. line 206

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.narrowPeak

# SYS command. line 207

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_peaks.xls

# SYS command. line 208

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_summits.bed

# SYS command. line 210

 if [[ true == "false" ]]; then \
			rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_treat_pileup.bdg "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_control_lambda.bdg; \
			TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi; \
			exit; \
		fi

# SYS command. line 216

 macs2 bdgcmp -t "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_treat_pileup.bdg -c "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_control_lambda.bdg \
			--o-prefix "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf" -m FE

# SYS command. line 218

 slopBed -i "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_FE.bdg -g "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" -b 0 | bedClip stdin "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.bedgraph

# SYS command. line 219

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_FE.bdg

# SYS command. line 221

 sort -k1,1 -k2,2n /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.bedgraph > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.srt.bedgraph

# SYS command. line 222

 bedGraphToBigWig /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.srt.bedgraph "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/signal/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.bigwig"

# SYS command. line 223

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.bedgraph /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.fc.signal.srt.bedgraph

# SYS command. line 226

 sval=$(wc -l <(zcat -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/align/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.tagAlign.gz") | awk '{printf "%f", $1/1000000}')

# SYS command. line 228

 macs2 bdgcmp \
			-t "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_treat_pileup.bdg -c "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_control_lambda.bdg \
			--o-prefix "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf" -m ppois -S "${sval}"

# SYS command. line 231

 slopBed -i "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_ppois.bdg -g "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" -b 0 | bedClip stdin "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.bedgraph

# SYS command. line 232

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_ppois.bdg

# SYS command. line 234

 sort -k1,1 -k2,2n /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.bedgraph > /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.srt.bedgraph

# SYS command. line 235

 bedGraphToBigWig /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.srt.bedgraph "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/signal/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.bigwig"

# SYS command. line 236

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.bedgraph /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval.signal.srt.bedgraph

# SYS command. line 238

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_treat_pileup.bdg "/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R1_treated/out/peak/macs2/pooled_rep/H9_Fucci_LateG1_D1_S29_L004_R1_001.trim.PE2SE.nodup.tn5_pooled.pf"_control_lambda.bdg

# SYS command. line 240

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
