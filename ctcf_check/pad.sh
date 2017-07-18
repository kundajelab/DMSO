#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_earlyG1_dmso_control_UP.bed \
#       --desired_length 1552 \
#       --output_bed atac_earlyG1_dmso_control_UP.padded.bed


#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_earlyG1_dmso_control_DOWN.bed \
#       --desired_length 1276 \
#       --output_bed atac_earlyG1_dmso_control_DOWN.padded.bed


#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_lateG1_dmso_control_UP.bed \
#       --desired_length 1552 \
#       --output_bed atac_lateG1_dmso_control_UP.padded.bed


#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_lateG1_dmso_control_DOWN.bed \
#       --desired_length 1337 \
#       --output_bed atac_lateG1_dmso_control_DOWN.padded.bed


#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_sg2m_dmso_control_UP.bed \
#       --desired_length 1552 \
#       --output_bed atac_sg2m_dmso_control_UP.padded.bed


#python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atac_sg2m_dmso_control_DOWN.bed \
#       --desired_length 1137 \
#       --output_bed atac_sg2m_dmso_control_DOWN.padded.bed

#pad the overall merged atacseq peaks to 3772 bases

python /srv/scratch/annashch/hocomoco_scan/pad.py --input_bed atacseq_merged.peaks.bed \
       --desired_length 3772 \
       --output_bed atacseq_merged.peaks.padded.bed

