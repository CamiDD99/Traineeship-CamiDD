# Retrieving the percentage from the short summary file from each genome
# I am in the BUSCO-summaries folder (/home/guest/Traineeship/Data/busco/BUSCO-summaries)

NAME=$(for i in *
do
    echo $i | sed 's/^[^-]*-//g' | sed 's/.txt//g' | sed 's/^\([^_]*\)_/M_/'
done)

echo $NAME > name2.txt

scaffolds=$(for i in *
do
    grep 'scaffolds' ./$i | sed -E 's/^([^\t]*\t[^\t]*)\t.*/\1/'
done)

echo $scaffolds > scaffolds.txt
