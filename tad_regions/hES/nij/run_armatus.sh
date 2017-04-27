for i in `seq 1 23`
do
    armatus -i nij.chr$i.gz -r 5000 -g 1.0 -s 0.05 -c $i -o tad.chr$i -m 
    echo $i
done
