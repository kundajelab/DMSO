#Embedded file name: /srv/scratch/annashch/deeplearning/utils/fastaFromBed.py
import sys
import pysam
from Params import * 
refseq = 'encodeHg19Male.fa'
ref_source = pysam.FastaFile(refseq)
chrom="chr9"
pos_start=110243373
pos_end=110243382
seq = ref_source.fetch(chrom, pos_start, pos_end)
print str(seq) 
