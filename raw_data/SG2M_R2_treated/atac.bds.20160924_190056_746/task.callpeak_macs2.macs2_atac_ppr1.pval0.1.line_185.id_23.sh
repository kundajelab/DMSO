#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated'

# SYS command. line 187

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 188

 export LC_COLLATE=C

# SYS command. line 190

 macs2 callpeak \
			-t /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.tagAlign.gz -f BED -n "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1" -g "hs" -p 0.1 \
			--nomodel --shift -75 --extsize 150 --broad --keep-dup all

# SYS command. line 195

 sort -k 8gr,8gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.broadPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.broadPeak.gz

# SYS command. line 196

 sort -k 14gr,14gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.gappedPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.gappedPeak.gz

# SYS command. line 197

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.broadPeak

# SYS command. line 198

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.gappedPeak

# SYS command. line 200

 macs2 callpeak \
			-t /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.tagAlign.gz -f BED -n "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1" -g "hs" -p 0.1 \
			--nomodel --shift -75 --extsize 150 -B --SPMR --keep-dup all --call-summits

# SYS command. line 205

 sort -k 8gr,8gr "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.narrowPeak | awk 'BEGIN{OFS="\t"}{$4="Peak_"NR ; print $0}' | gzip -c > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.narrowPeak.gz

# SYS command. line 206

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.narrowPeak

# SYS command. line 207

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_peaks.xls

# SYS command. line 208

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_summits.bed

# SYS command. line 210

 if [[ false == "false" ]]; then \
			rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_treat_pileup.bdg "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_control_lambda.bdg; \
			TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi; \
			exit; \
		fi

# SYS command. line 216

 macs2 bdgcmp -t "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_treat_pileup.bdg -c "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_control_lambda.bdg \
			--o-prefix "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1" -m FE

# SYS command. line 218

 slopBed -i "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_FE.bdg -g "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" -b 0 | bedClip stdin "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.bedgraph

# SYS command. line 219

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_FE.bdg

# SYS command. line 221

 sort -k1,1 -k2,2n /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.bedgraph > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.srt.bedgraph

# SYS command. line 222

 bedGraphToBigWig /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.srt.bedgraph "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/signal/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.bigwig"

# SYS command. line 223

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.bedgraph /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.fc.signal.srt.bedgraph

# SYS command. line 226

 sval=$(wc -l <(zcat -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.tagAlign.gz") | awk '{printf "%f", $1/1000000}')

# SYS command. line 228

 macs2 bdgcmp \
			-t "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_treat_pileup.bdg -c "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_control_lambda.bdg \
			--o-prefix "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1" -m ppois -S "${sval}"

# SYS command. line 231

 slopBed -i "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_ppois.bdg -g "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" -b 0 | bedClip stdin "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.bedgraph

# SYS command. line 232

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_ppois.bdg

# SYS command. line 234

 sort -k1,1 -k2,2n /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.bedgraph > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.srt.bedgraph

# SYS command. line 235

 bedGraphToBigWig /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.srt.bedgraph "/srv/gsfs0/projects/kundaje/commonRepository/annotations/human/hg19.GRCh37/genomeSize/hg19.genome" "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/signal/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.bigwig"

# SYS command. line 236

 rm -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.bedgraph /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1.pval.signal.srt.bedgraph

# SYS command. line 238

 rm -f "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_treat_pileup.bdg "/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/pooled_pseudo_reps/ppr1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pr1.tn5_pooled.pf.pval0.1"_control_lambda.bdg

# SYS command. line 240

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
