for i in earlyG1_R1_controls  earlyG1_R1_treated earlyG1_R2_controls earlyG1_R2_treated lateG1_R1_controls lateG1_R1_treated lateG1_R2_controls lateG1_R2_treated SG2M_R1_controls SG2M_R1_treated SG2M_R2_controls SG2M_R2_treated 
do 
scp $i/out/signal/macs2/pooled_rep/*pval* annashch@mitra:/srv/www/kundaje/annashch/dmso 
done 

