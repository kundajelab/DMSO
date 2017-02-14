cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/signal/macs2/rep1/fc.values.bed > 1
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R1_controls/out/signal/macs2/rep2/fc.values.bed > 2
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R1_treated/out/signal/macs2/rep1/fc.values.bed > 3
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R1_treated/out/signal/macs2/rep2/fc.values.bed > 4

cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R2_controls/out/signal/macs2/rep1/fc.values.bed > 5
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R2_controls/out/signal/macs2/rep2/fc.values.bed > 6
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R2_treated/out/signal/macs2/rep1/fc.values.bed > 7
cut -f2 -d'|' /srv/scratch/annashch/dmso/earlyG1_R2_treated/out/signal/macs2/rep2/fc.values.bed > 8

cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R1_controls/out/signal/macs2/rep1/fc.values.bed > 9
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R1_controls/out/signal/macs2/rep2/fc.values.bed > 10
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R1_treated/out/signal/macs2/rep1/fc.values.bed > 11
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R1_treated/out/signal/macs2/rep2/fc.values.bed > 12

cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R2_controls/out/signal/macs2/rep1/fc.values.bed > 13
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R2_controls/out/signal/macs2/rep2/fc.values.bed > 14
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R2_treated/out/signal/macs2/rep1/fc.values.bed > 15
cut -f2 -d'|' /srv/scratch/annashch/dmso/lateG1_R2_treated/out/signal/macs2/rep2/fc.values.bed > 16

cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R1_controls/out/signal/macs2/rep1/fc.values.bed > 17
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R1_controls/out/signal/macs2/rep2/fc.values.bed > 18
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R1_treated/out/signal/macs2/rep1/fc.values.bed > 19
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R1_treated/out/signal/macs2/rep2/fc.values.bed > 20

cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R2_controls/out/signal/macs2/rep1/fc.values.bed > 21
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R2_controls/out/signal/macs2/rep2/fc.values.bed > 22
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R2_treated/out/signal/macs2/rep1/fc.values.bed > 23
cut -f2 -d'|' /srv/scratch/annashch/dmso/SG2M_R2_treated/out/signal/macs2/rep2/fc.values.bed > 24

paste 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 > macs.fc.tab

