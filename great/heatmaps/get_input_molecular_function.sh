for i in shown-geneFamilies.tsv  shown-GOMolecularFunction.tsv  shown-interpro.tsv  shown-MSigDBGeneSetsCanonicalPathway.tsv  shown-MSigDBGeneSetsPromoterMotifs.tsv  shown-treefam.tsv shown-MGIExpressionDetected.tsv
do
    python get_input_molecular_function.py $i 
done
