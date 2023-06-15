# Loading packages
library(xlsx)
library(ggplot2)
#library(magrittr)
#library(tidyr)
library(reshape2)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP5")
data <- read.xlsx("MA_DIM_Results_NoHead.xlsx",1,header=TRUE)

# Putting first column as row names and keeping the first column
row.names(data) <- data$Locus.tag
# Melting dataframe so everything because data in columns
data_melted <- melt(data, id.vars=c("Locus.tag"))

# Making heatmap of all data
ggplot(data_melted, aes(x=Locus.tag, y=variable, fill=value)) +
  geom_tile() + 
  #ggtitle("Presence/absence of MA DIM genes") +
  # Legend labels and colors of legend
  scale_fill_manual(values=c("#7fb3d5","#1a5276"),
                    labels=c("Gene absent","Gene present")) +
  # Axis labels and positions
  ylab("Species") +
  scale_y_discrete(position="right") +
  xlab("MA and DIM biosynthesis genes") +
  scale_x_discrete(position="top") +
  theme(# No axis text and ticks, changing size of axis labels
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x=element_text(size=15),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y=element_text(size=15),
        # No grid or grey background
        panel.background=element_blank(),
        panel.grid.major=element_blank(),
        # Legend position stuff, no legend title and size of legend items
        legend.position="top",
        legend.justification="left",
        legend.direction="vertical",
        legend.title=element_blank(),
        legend.text=element_text(size=20),
        legend.spacing.y=unit(0.5,"cm")) +
  # Necessary to put 0.5 cm of space between legend items
  guides(fill=guide_legend(byrow=TRUE))
# Saving heatmap
ggsave("Heatmap.png",width=12, height=15)


## When only using subset of data --> labels were not perfect
# Subsetting data (not using all of it)
#subset <- data.frame(data$Locus.tag,data$Candidatus.M.alkanivorans,data$M.ahvazicum,data$M.alsense,data$M.angelicum,data$M.avium.subsp..avium,data$M.avium.subsp..hominissuis)
#subset2 <- subset[1:30, ]
# Putting first column as row names and keeping the first column
#row.names(subset2) <- subset2$data.Locus.tag
# Melting dataframe so everything because data in columns
#subset3 <- melt(subset2, id.vars=c("data.Locus.tag"))
# Removing all data. from the variable column
#subset4 <- transform(subset3, variable = sub("data.","",variable))

# Making heatmap of subset
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
ggsave("Heatmap_subset.png",width=15, height=15)





