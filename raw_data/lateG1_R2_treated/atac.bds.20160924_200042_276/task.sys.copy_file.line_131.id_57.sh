#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated'

# SYS command. line 133

 cp --remove-destination /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/pooled_pseudo_reps/ppr.IDR0.1.filt.narrowPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/optimal_set/ppr.IDR0.1.filt.narrowPeak.gz

# SYS command. line 134

 while [ ! -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/lateG1_R2_treated/out/peak/idr/optimal_set/ppr.IDR0.1.filt.narrowPeak.gz ]; do echo FOUND DELAYED WRITE, WAITING...; sleep 0.1; done
