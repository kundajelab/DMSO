#!/bin/bash -e

cd '/srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_controls'

# SYS command. line 133

 cp --remove-destination /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_controls/out/peak/idr/true_reps/rep1-rep2/rep1-rep2.IDR0.1.filt.narrowPeak.gz /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_controls/out/peak/idr/optimal_set/rep1-rep2.IDR0.1.filt.narrowPeak.gz

# SYS command. line 134

 while [ ! -f /srv/gsfs0/projects/kundaje/users/annashch/dmso/SG2M_R1_controls/out/peak/idr/optimal_set/rep1-rep2.IDR0.1.filt.narrowPeak.gz ]; do echo FOUND DELAYED WRITE, WAITING...; sleep 0.1; done
