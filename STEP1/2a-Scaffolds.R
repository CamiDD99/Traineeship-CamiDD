## Filtering the list of Mycogenomes
################################################################################
# Downloading/loading packages
library(xlsx)

# Loading file
setwd("/home/guest/Traineeship/Scripts/STEP1/")
file <- read.csv("1d-allMyco_ncbigenome_overview3.csv", sep="\t", header=TRUE)

# Retaining only those assemblies with < 10 scaffolds (3073 assemblies kept)
scaf10 <- file[which(file$Scaffolds<10),]


# Only retaining a genome per (sub)species (with variant/strain) of the list 
# with < 10 scaffolds (1336 assemblies kept)
species10 <- distinct(scaf10, X.Organism.Name, .keep_all=TRUE)


# Saving in xlsx file
write.xlsx(x = species10, 
           file = "MycoGenomes.xlsx",
           sheetName = "1",
           row.names = FALSE)
