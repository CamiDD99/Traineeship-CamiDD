#!/bin/bash
# Assigning the correct name

i=${PWD##*/}

mv *_assembly_report.txt ${i}_assembly_report.txt 
mv *_assembly_stats.txt ${i}_assembly_stats.txt
mv *_cds_from_genomic.fna.gz ${i}_cds_from_genomic.fna.gz
mv *_feature_count.txt.gz ${i}_feature_count.txt.gz
mv *_feature_table.txt.gz ${i}_feature_table.txt.gz
mv *_genomic.gbff.gz ${i}_genomic.gbff.gz
mv *_genomic.gff.gz ${i}_genomic.gff.gz
mv *_genomic.gtf.gz ${i}_genomic.gtf.gz
mv *_protein.faa.gz ${i}_protein.faa.gz
mv *_protein.gpff.gz ${i}_protein.gpff.gz
mv *_rna_from_genomic.fna.gz ${i}_rna_from_genomic.fna.gz
mv *_translated_cds.faa.gz ${i}_translated_cds.faa.gz
mv *_wgsmaster.gbff.gz ${i}_wgsmaster.gbff.gz
mv G*_genomic.fna.gz ${i}_genomic.fna.gz
