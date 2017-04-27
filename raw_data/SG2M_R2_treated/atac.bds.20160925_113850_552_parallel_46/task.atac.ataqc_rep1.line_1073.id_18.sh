#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated'

# SYS command. line 1075

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 1078

 export _JAVA_OPTIONS="-Xms256M -Xmx11G -XX:ParallelGCThreads=1"

# SYS command. line 1080

 cd /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1

# SYS command. line 1083

 if [ -f "$(which picard)" ]; then export PICARDROOT="$(dirname $(which picard))/../share/picard"*; fi

# SYS command. line 1085

 /home/annashch/bds_atac/ataqc/run_ataqc.py \
		    --workdir /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1 \
		    --outdir /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1 \
		    --outprefix H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.PE2SE \
		    --genome hg19 \
		    --ref /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/encodeHg19Male.fa \
		    --tss /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/hg19_RefSeq_stranded.bed.gz \
		    --dnase /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/reg2map_honeybadger2_dnase_all_p10_ucsc.bed.gz \
		    --blacklist /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/blacklist_idr/wgEncodeDacMapabilityConsensusExcludable.bed.gz \
		    --prom /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/reg2map_honeybadger2_dnase_prom_p2.bed.gz \
		    --enh /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/reg2map_honeybadger2_dnase_enh_p2.bed.gz \
		    --reg2map /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/dnase_avgs_reg2map_p10_merged_named.pvals.gz \
		    --meta /srv/gsfs0/projects/kundaje/users/jinlee/data/hg19/ataqc/eid_to_mnemonic.txt \
		    --pbc /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.pbc.qc\
		    --fastq1 /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.fastq.gz --fastq2 /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/H9_Fucci_SG2M_R2_D1_S45_L005_R2_001.fastq.gz \
		    --alignedbam /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.bam \
		    --alignmentlog /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.align.log \
		    --coordsortbam /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.bam \
		    --duplog /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.dup.qc \
		    --finalbam /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.bam \
		    --finalbed /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/align/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.tn5.tagAlign.gz \
		    --bigwig /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/signal/macs2/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.tn5.pf.pval.signal.bigwig \
		    --peaks /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/rep1/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.tn5.pf.narrowPeak.gz \
		    --naive_overlap_peaks /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/macs2/overlap/H9_Fucci_SG2M_R2_D1_S45_L005_R1_001.trim.PE2SE.nodup.tn5_pooled.pf.pval0.1.500K.naive_overlap.narrowPeak.gz \
		    --idr_peaks /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/peak/idr/optimal_set/ppr.IDR0.1.filt.narrowPeak.gz \
		    

# SYS command. line 1112

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
