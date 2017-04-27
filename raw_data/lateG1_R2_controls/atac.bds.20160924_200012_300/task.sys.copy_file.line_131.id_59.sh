#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls'

# SYS command. line 133

 cp --remove-destination /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.12-col.bed.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/peak/idr/optimal_set/ppr.IDR0.1.filt.12-col.bed.gz

# SYS command. line 134

 while [ ! -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_controls/out/peak/idr/optimal_set/ppr.IDR0.1.filt.12-col.bed.gz ]; do echo FOUND DELAYED WRITE, WAITING...; sleep 0.1; done
