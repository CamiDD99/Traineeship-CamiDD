#!/bin/bash
# Copying the files needed for busco (run this script in busco folder on the server)

for i in ../genbankFiles/*
do
    cp $i/*_genomic.fna.gz genomes/
done


# Removing the files that are not needed
cd /mnt/DATA2/cami/busco/genomes

rm *_cds_from_genomic.fna.gz
rm *_rna_from_genomic.fna.gz


# Unzipping files
for i in *
do
    gzip -d $i
done
