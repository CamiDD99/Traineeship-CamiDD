#!/bin/bash
# Copying the files needed for panaroo (run this script in panaroo folder on the server)

for i in ../prokka/genomes/prokka-*
do
    cp $i/*_genomic.gff.gz .
done

# Unzipping files
for i in *
do
    gzip -d $i
done