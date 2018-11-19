for timepoint in earlyG1 lateG1 SG2M
do

    cut -f1,3 CellCycle$timepoint.TreatmentDMSO.tsv | grep "-" | cut -f1 -d "_" | sort |uniq | grep -v "baseMean" > $timepoint.down.genes.txt
    cut -f1,3 CellCycle$timepoint.TreatmentDMSO.tsv | grep -v "-" | cut -f1 -d "_" | sort |uniq | grep -v "baseMean" > $timepoint.up.genes.txt

done
