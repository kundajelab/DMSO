#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R1_treated'

# SYS command. line 133

 cp --remove-destination /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R1_treated/out/peak/idr/true_reps/rep1-rep2/rep1-rep2.IDR0.1.filt.12-col.bed.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R1_treated/out/peak/idr/optimal_set/rep1-rep2.IDR0.1.filt.12-col.bed.gz

# SYS command. line 134

 while [ ! -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/earlyG1_R1_treated/out/peak/idr/optimal_set/rep1-rep2.IDR0.1.filt.12-col.bed.gz ]; do echo FOUND DELAYED WRITE, WAITING...; sleep 0.1; done
