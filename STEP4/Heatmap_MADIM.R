# Loading packages
library(xlsx)
library(ggplot2)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP4")
data <- read.xlsx("MA_DIM_Results.xlsx",1,header=TRUE)


# Subsetting data
subset <- data.frame(data$Locus.tag, data$Species, data$NA., data$NA..1, data$NA..3, data$NA..4)
subset2 <- subset[1:30, ]


# Making heatmap
ggplot(subset2, aes(x=data.Locus.tag, y=data.Species)) +
  geom_tile() 
## Candidatus_M_alk.. is also in the heatmpa --> need to get it out + y-axis 
## should be species name
## Data should get in a different format

