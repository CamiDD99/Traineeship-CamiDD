# Loading packages
library(xlsx)
library(ggplot2)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP2/")
data <- read.xlsx("Scaffolds.xlsx",1,header=TRUE)

# Barplot
ggplot(data=data,aes(x=Organisms, y=Scaffolds)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ggtitle("Number of scaffolds per (sub)species")+
  scale_y_continuous(limits = c(0,10), expand = c(0,0)) +
  theme_bw() +
  theme(axis.text.y=element_text(size=9),
        axis.title.y=element_text(size=25),
        axis.text.x=element_text(size=25),
        axis.title.x=element_text(size=25),
        plot.title=element_text(size=30,hjust=0.5)) +
  geom_text(aes(label=Scaffolds),hjust=-0.2,size=4)

ggsave("barplot_scaffolds.png",width=25, height=30)
