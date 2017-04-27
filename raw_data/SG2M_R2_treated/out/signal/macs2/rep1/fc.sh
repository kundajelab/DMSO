bigWigToBedGraph *fc.signal.bigwig fc.bedgraph
awk '{ \
    if ($1 ~ /^chr/) { \
        print $1"\t"$2"\t"$3"\tid-"NR"\t"$4; \
    } \
}' fc.bedgraph > fc.bed
bedmap --echo --sum /srv/scratch/annashch/dmso/ppr.merged.bed fc.bed > fc.values.bed
