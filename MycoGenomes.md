# Roadmap Project Genera - Cami De Decker (April 2023 > June 2023)
In this document, you can find information on all the steps that I performed during my internship at ITM. This document is the path to where you can find files, folders, scripts and data that I generated during this time. I divided the tasks I performed in steps. All files and scripts that are used during these steps can be found on my [GitHub page](https://github.com/CamiDD99/Traineeship-CamiDD) in the folder with the same step number. All the generated data can be found on the server at /mnt/DATA2/cami, also in the folder with the same step number.  
On GitHub there is another file called MycoGenomes_Detailed.txt with more detailed information (like errors, problems ...) on what I did.

## **STEP 1** - Downloading mycobacterial genomes from NCBI
First download the prokaryotes.txt file from NCBI. From that file all the genomes belonging to the genus Mycobacterium are extracted and saved in a .txt file. Then the header line is added back to the 1b-* file. 

```
wget https://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/prokaryotes.txt

grep 'Mycobacterium' prokaryotes.txt >> 1b-allMyco_ncbigenome_overview.txt
grep 'Mycolicibacter' prokaryotes.txt >> 1b-allMyco_ncbigenome_overview.txt
grep 'Mycolicibacterium' prokaryotes.txt >> 1b-allMyco_ncbigenome_overview.txt
grep 'Mycolicibacillus' prokaryotes.txt >> 1b-allMyco_ncbigenome_overview.txt
grep 'Mycobacteroides' prokaryotes.txt >> 1b-allMyco_ncbigenome_overview.txt

head -n 1 prokaryotes.txt > header
cat header 1b-allMyco_ncbigenome_overview.txt > 1c-allMyco_ncbigenome_overview2.txt
```

With the use of an R script called *2a-Scaffolds.R*, the genomes with < 10 scaffolds are retained.  
*The results of this were saved in the file MycoGenomes.xlsx. That file then held a list of 1336 genomes. Since the list was very big, some extra criteria were decided so that the list would become smaller. If there was more than 1 genome for a (sub)species, I tried to retain only 1 strain. I used following cirteria, the genome with: < 3 scaffolds, most recent assembly date, complete genome status and/or presence in Taxonomy_Mycobacterium.xlsx were retained. I obtained a list of 255 genomes and saved the filtered list in a file called MycoGenomesFiltered.xlsx.*

After the filtering, the ftp path has to be extracted out of your list with genomes (21st column). With this path you can download the folder with data of the genomes. This is done with an R script called **2b-ftpURL.R**. This script makes a file called ftpURL.txt. This file is used together with the shell script **3-down_move_rename.sh** to download the folders. The shell script also moves your folder to a  location you specify and will rename the folder and files within to the name that is in the *report.txt file that every genome has.
```
mkdir <folder name>
sh 3-down_move_rename.sh ftpURL.txt
```


## **STEP 2** - Quality assessment of downloaded genomes
To accomplish this step, a tool called BUSCO was used. You can find the documentation of this tool [here](https://busco.ezlab.org/busco_userguide.html). The tool itself was installed with mamba in a conda environment (see [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) and [mamba](https://mamba.readthedocs.io/en/latest/installation.html) documentation for installation). 
```
conda create --yes --name busco
conda activate busco
mamba install -c conda-forge -c bioconda busco=5.4.7
```
When you have to run busco on a lot of genomes, it is best to download the dataset that it uses beforehand. Otherwise it will download a dataset each time you start the command. You can list all the available datasets and then download the one of your interest.  
*I used the bacteria_odb10 dataset.*
```
busco --list-datasets
busco --download <dataset of interest>
```
You need the fasta files as input, so it's best to put all the files you need for this tool in one folder. Then you can start BUSCO. If you have many genomes to assess, it is best to use a for loop. The part "name=$()" is used to specify only the genome name in the busco output folder name.
```
for i in *.fna;do name=$(echo $i | sed 's/_genomic.fna//g');echo $name;busco -f -c 8 -m genome -i $i -o BUSCO-$name -l <path to downloaded dataset>;done
```
To create one big overview file of the results (precisely percentage complete BUSCO), use following code and scripts (**4-after_busco.sh**). This will create two files that you can copy and paste together in one Excel sheet. Now you have an overview of all the percentages. You can use this file to remove all the genomes that have a percentage under your cutoff.  
*I saved the output of this shell script in the file called BUSCO_percentages.xlsx. I removed all the genomes that had a percentage of <95% and that still had multiple strains. My previous list of 255 genomes became a list of 202 genomes. This was aved in the file called MycoGenomesFilteredBUSCO.xlsx* 
```
mkdir <folder name>
for i in B*;do cd $i;cp *.txt <folder name> ;cd ..;done
sh 4-after_busco.sh
```


## **STEP 3** - Building a phylogenetic tree
To build a phylogenetic tree, two parts have to be done. You have to produce a core genome and use that core genome to infer a phylogenetic tree. For the first part, a tool called SCARAP was used. You can find the documentation of scarap [here](https://github.com/SWittouck/SCARAP). For the second part, a tool called RAxML-ng was used. You can find the documentation of RAxML-ng [here](https://github.com/amkozlov/raxml-ng).  
### SCARAP
Install the dependencies (see documentation) of SCARAP in a conda environment. Download the code of SCARAP from GitHub. To make it easy for yourself, put an alias in your .bashrc file.
```
conda create --yes --name scarap
conda activate scarap
mamba install <dependencies>
git clone https://github.com/SWittouck/SCARAP.git
nano .bashrc
> scarap="<path to scarap.py script>"
source .bashrc
```
Get all of the input files (.faa) in one folder. Run SCARAP with mode core to get the core genes. This command will create, among other things, the file genes.tsv. This file is used as the input for the second command.  
*There were 1413 core genes found when I ran the command.*
```
scarap core <input folder with .faa files> <output folder> -t 4
```
To make one big concatenated alignment of the core genes. Use the mode concat. This will generate a fasta file (supermatrix_aas.fasta) containg the "supermatrix" which is a concatenated alignment of the core genes.
```
scarap concat <input folder with .faa files> <path to genes.tsv> <output folder> -t 5
```
### RAxML-ng
To start RAxML-ng, you need the file called supermatrix_aas.fasta from the previous command. RAxML-ng has a mode where it lets you see the recommended number of threads as well as the amount of storage that is required. It also checks if your file is readable. Use the following command for this. It will recommend you to use another command with the --parse option to reduce the size of the file. However, you don't need to do this.
```
raxml-ng --check --msa supermatrix_aas.fasta --model LG+G --prefix <specify a prefix>
```
Now you can start the command. Here you use the option --search to find the best ML tree. The model LG+G was used since we are working with AAs.
```
raxml-ng --search  --msa supermatrix_aas.fasta --prefix <specify a prefix> --threads <recommended number> --model LG+G 
```


## **STEP 4** - Pathogenicity of nontuberculous mycobacteria
During this step, the focus is on:
- determining the presence/absence of genes involved in mycolic acid (MA) and dimycocerosate (DIM) biosynthesis,
- predicting plasmids,
- detecting prophages,
- detecting genomic islands and
- detecting virulence factors. 

### Presence/absence genes in MA and DIM biosynthesis
To accomplish this, BLAST+ is used to make a BLAST database of the reference genes. You can find the documentation of BLAST+ [here](https://www.ncbi.nlm.nih.gov/books/NBK279690/). The genes that are of interest here are the genes involved in mycolic acid (MA) and dimycocerosate (DIM) biosynthesis and are annotated from the genome of *M. tuberculosis H37Rv*.  
*I used the genes that were in the file MA_DIM_genes.xlsx. I found this file as the supplementary table 10 of Fedrizzi, T., Meehan, C., Grottola, A. et al. Genomic characterization of Nontuberculous Mycobacteria. Sci Rep 7, 45258 (2017). https://doi.org/10.1038/srep45258.*  
First, create a conda environment where you install BLAST+. 
```
conda create --name blast
mamba install -c bioconda blast
```
The sequences of the reference genes are downloaded from [Mycobrowser](https://mycobrowser.epfl.ch/). Get all of the sequences in one big fasta file. Use this file *(I saved it as Ma_DIM.fasta)* to create the database. The option -parse_seqids is specified to retain the full names of the sequences. 
```
makeblastdb -in MA_DIM.fasta -title MA_DIM_db -dbtype nucl -out MA_DIM -parse_seqids
```
Now you can BLAST the genomes (fasta files) against the database. Since this database is small (only 80 sequences), an e-value cutoff of -10 is chosen. A lot of genomes have to be BLASTed, so use a for loop to make it quicker. 
```
for i in *.fna;do name=$(echo $i | sed 's/_genomic.fna//g');blastn -query $i -db db/MA_DIM -out $name.txt -evalue 1e-10;done
```

### Prediction of plasmids
To accomplish this, the tool PlasForest was used. You can find the documentation of PlasForest [here](https://github.com/leaemiliepradier/PlasForest). Install the dependencies in a conda environment. Clone the GitHub repository and install PlasForest.
```
conda create --yes --name plasforest
conda activate plasforest
mamba install <dependencies>
tar -xzvf plasforest.sav.tar.gz
chmod 755 database_downloader.sh
./database_downloader.sh
```
Test run PlasForest to see if it works.
```
./test_plasforest.sh
```
Now you can run PlasForest. 
```
for i in ../Input_PlasForest/* ;do name=$(echo $i | sed 's/_genomic.fna/_Result.csv/g' | sed 's/..\/Input_PlasForest\///g') ; ./PlasForest.py -i ../Input_PlasForest/$i -o ../Output_PlasForest/$name --threads 4;done
```

### Detection of prophages
For the detection of prophages, the tool PHASTER was chosen. You can find the website of PHASTER [here](https://phaster.ca/). There is an URL API that you can use when you have many genomes you want to run the tool on. When you run this, it will generate an output file for each genome with a job ID and status. The status can be "You're next" or "There are x submission ahead of you". You can check if any results are generated by using follwing URL: https://phaster.ca/submissions/specify_job_ID_in_output_file.  
*I ran the command for all the genomes. In the output files it was specified that there were more than 1083 submissions before me. I started it on a Wednesday and on Friday still no results were generated.*
```
for i in *.fna;do name=$(echo $i | sed 's/_genomic.fna//g');wget --post-file=$i "http://phaster.ca/phaster_api?contigs=1" -O ../Output_phaster/PHASTER-$name;done
```
*You can find the output file with jobID and status for each genome on the server in /mnt/DATA2/cami/STEP4/Output_phaster.*  

### Detection of genomic islands
For the detection of genomic islands, the tool IslandViewer4 was chosen. You can find the website of IslandViewer4 [here](https://www.pathogenomics.sfu.ca/islandviewer/).  

### Detection of virulence factors
For the detection of virulence factors, it was decided to BLAST the genomes against the VFDB (Virulence Factor DataBase). You can find the website of VFDB [here](http://www.mgc.ac.cn/VFs/).  


## **STEP 5** - Processing and analyzing data of STEP4
The scripts used for the analyzation of the data generated in STEP4 are in the folder STEP5.  

### Presence/absence genes in MA and DIM biosynthesis
To make one big overview file of all the results, extract only the hits out of each file. Then use the python script called **MA_DIM_summary.py** to make an Excel sheet of the results. If you want to create a heatmap of the results, use the R script **Heatmap_MADIM.R**.
```
for i in *.txt;do name=$(echo $i | sed 's/.txt/_Result.txt/g') ;grep "^Rv" $i > $name ;done
```
*The Excel file with the results is called Ma_DIM_Results.xlsx.*

### Prediction of plasmids
To make one big overview file of all the results, use the python script called **PlasForest_summary.py**. This script creates a .csv file.  
*The output of the script is called PlasForest_Summary.csv. I opened the script and saved it as an .xlsx file instead. I added the plasmid data to the ClinicalRelevance_Plasmids.xlsx file. Based on this file some correlations can be possibly made. However, it wasn't entirely clear what the data in some columns meant. In particular the data in the column Potentially clinically relevant wasn't clear.*

### Detection of prophages

### Detection of genomic islands

### Detection of virulence factors

## **Extra**
On the GitHub page, you can find the file MycoGenomeUpToDate.xlsx. This is a file with a list of all the Mycobacterium species. In there it is specified if there is a high quality genome present for that species. The ones that are in red are species that were not in the list yet and that I added.  
In the folder STEP4 on GitHub, you can find the file with the percentages of Horizontal Gene Transfer (HGT). It is saved in a file called Percentage_HGT.xlsx. In this folder you can also find my information of my literature search for tools.