for timepoint in earlyG1 lateG1 SG2M
do
    echo $timepoint
    cut -f1,3 CellCycle$timepoint.TreatmentDMSO.tsv | grep  "-" | cut -f1 |grep -v "baseMean" | sed --expression "s/\_/\t/g" > $timepoint.down.bed
    cut -f1,3 CellCycle$timepoint.TreatmentDMSO.tsv | grep -v "-" | cut -f1 |grep -v "baseMean" | sed --expression "s/\_/\t/g" > $timepoint.up.bed
done
