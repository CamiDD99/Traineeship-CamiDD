# Retrieving the percentage from the short summary file from each genome
# I am in the BUSCO-summaries folder (/home/guest/Traineeship/Data/busco/BUSCO-summaries)

NAME=$(for i in *
do
    name_txt=$(echo $i | sed 's/^[^-]*-//g')
    echo $name_txt | sed 's/.txt//g'
done)

echo $NAME > name.txt

BUSCO_perc=$(for i in *
do
    grep 'C:' ./$i | sed 's/\[.*$//g';
done)

echo $BUSCO_perc > percentage.txt
