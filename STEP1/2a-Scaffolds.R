## Filtering the list of Myco... genomes
################################################################################
# Downloading/loading packages
pkg <- installed.packages()[, "Package"]
if(!('dplyr' %in% pkg)) { install.packages("dplyr") }
library(dplyr)
library(xlsx)

# Loading file
setwd("/home/guest/Traineeship/STEP1/")
file <- read.csv("1d-allMyco_ncbigenome_overview3.csv", sep="\t", header=TRUE)

# Retaining only those assemblies with < 10 scaffolds (3073 assemblies kept)
scaf10 <- file[which(file$Scaffolds<10),]
# Retaining only those assemblies with 1 scaffold (1157 assemblies kept)
#scaf1 <- file[which(file$Scaffolds==1),]

# Only retaining 1 (sub)species (with variant/strain) of the list with species 
# < 10 scaffolds (1336 assemblies kept)
species10 <- distinct(scaf10, X.Organism.Name, .keep_all=TRUE)
# Only retaining 1 species of the list with species = 1 scaffolds (412 assemblies kept)
#species1 <- distinct(scaf1, X.Organism.Name, .keep_all=TRUE)

# Saving in xlsx file
write.xlsx(x = species10, 
           file = "MycoGenomes.xlsx",
           sheetName = "1",
           row.names = FALSE)
