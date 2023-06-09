# Loading packages
library(xlsx)
library(ggplot2)
library(magrittr)
library(tidyr)
library(reshape2)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP5")
data <- read.xlsx("MA_DIM_Results_NoHead.xlsx",1,header=TRUE)

# Subsetting data (not using all of it)
subset <- data.frame(data$Locus.tag,data$Candidatus.M.alkanivorans,data$M.ahvazicum,data$M.alsense,data$M.angelicum,data$M.avium.subsp..avium,data$M.avium.subsp..hominissuis)
subset2 <- subset[1:30, ]
# Putting first column as row names and keeping the first column
row.names(subset2) <- subset2$data.Locus.tag
# Melting dataframe so everything because data in columns
subset3 <- melt(subset2, id.vars=c("data.Locus.tag"))
# Removing all data. from the variable column
subset4 <- transform(subset3, variable = sub("data.","",variable))

# Making heatmap
ggplot(subset4, aes(x=data.Locus.tag, y=variable, fill=value)) +
  geom_tile() + 
  #ggtitle("Presence/absence of MA DIM genes") +
  scale_x_discrete(position="top") +
  scale_y_discrete(position="right") +
  scale_fill_discrete(labels=c("Gene absent","Gene present")) +
  theme(axis.text.x=element_text(angle=45, vjust=1, hjust=0),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),
        panel.grid.major=element_blank(),
        legend.position="top",
        legend.title=element_blank()) 


