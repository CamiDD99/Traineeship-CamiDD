#!/bin/bash
# Downloading all the sequences with wget
# $1 is the file with all the ftp locations
DIR="/mnt/DATA2/cami/genbankFiles/" 
while read LINE
do
	for URL in "$LINE"
	do
		wget -P $DIR -r $URL
	done < $1
done < $1


# Put all files in 1 folder
cd /mnt/DATA2/cami/genbankFiles/ftp.ncbi.nlm.nih.gov/genomes/all/
for d in *
do
	cd $d

	for i in *;
	do
		cd $i
		
		for j in *
		do	
			cd $j

			for k in *
			do
				cd $k
				mv * ../../../../../../..
				cd ..
			done
			cd ..
		done
		cd ..
	done
	cd ..
done
echo "$PWD"

# Removing the ftp.ncbi.nlm.nih.gov folder
cd /mnt/DATA2/cami/genbankFiles/
rm -r ftp.ncbi.nlm.nih.gov

# Renaming based upon what is in the organism name of the report file
for i in *
do
    name=$(grep 'Organism name' $i/*report.txt|sed 's/# Organism name:  //g'|sed 's/ (.*//g'|sed 's/ /_/g')
    mv $i $name
done


# Renaming files based on folder name
cd /mnt/DATA2/cami/genbankFiles/

for i in M*
do 
    cd $i
    mv *_assembly_report.txt ${i}_assembly_report.txt 
    cd ..
done

for i in M*
do 
    cd $i
    mv *_assembly_stats.txt ${i}_assembly_stats.txt
    cd ..
done

for i in M*
do 
    cd $i
    mv *_cds_from_genomic.fna.gz ${i}_cds_from_genomic.fna.gz 
    cd ..
done

for i in M*
do 
    cd $i
    mv *_feature_count.txt.gz ${i}_feature_count.txt.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_feature_table.txt.gz ${i}_feature_table.txt.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_genomic.gbff.gz ${i}_genomic.gbff.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_genomic.gff.gz ${i}_genomic.gff.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_genomic.gtf.gz ${i}_genomic.gtf.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_protein.faa.gz ${i}_protein.faa.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_protein.gpff.gz ${i}_protein.gpff.gz
    cd ..
done

for i in M*
do
    cd $i
    mv *_rna_from_genomic.fna.gz ${i}_rna_from_genomic.fna.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_translated_cds.faa.gz ${i}_translated_cds.faa.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv *_wgsmaster.gbff.gz ${i}_wgsmaster.gbff.gz
    cd ..
done

for i in M*
do 
    cd $i
    mv G*_genomic.fna.gz ${i}_genomic.fna.gz
    cd ..
done
