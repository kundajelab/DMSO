#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated'

# SYS command. line 207

 if [[ -f $(which conda) && $(conda env list | grep bds_atac | wc -l) != "0" ]]; then source activate bds_atac; fi;  export PATH=/home/annashch/bds_atac/.:/home/annashch/bds_atac/modules:/home/annashch/bds_atac/utils:${PATH}:/bin:/usr/bin:/usr/local/bin:${HOME}/.bds; set -o pipefail; STARTTIME=$(date +%s); renice -n 0 $$

# SYS command. line 209

 echo -e "Nt\tN1	N2	""Np\tconservative_set\toptimal_set\trescue_ratio\tself_consistency_ratio\treproducibility" > /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/IDR_final.qc

# SYS command. line 210

 echo -e "122344\t100884	86665	""124551\trep1-rep2\tpooled_pseudo_rep\t1.0180392990256981\t1.1640685397796111\t1" >> /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R2_treated/out/qc/IDR_final.qc

# SYS command. line 212

 TASKTIME=$[$(date +%s)-${STARTTIME}]; if [ ${TASKTIME} -lt 60 ]; then echo "Waiting for $[60-${TASKTIME}] seconds."; sleep $[60-${TASKTIME}]; fi
