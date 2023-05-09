# Loading packages
library(xlsx)
library(ggplot2)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP2/")
data <- read.xlsx("Contigs.xlsx",1,header=TRUE)

# Barplot
ggplot(data=data,aes(x=Organisms, y=Contigs)) +
  geom_bar(stat="identity") +
  coord_flip() +
  ggtitle("Number of contigs per (sub)species")+
  scale_y_continuous(limits = c(0,370), expand = c(0,0)) +
  theme_bw() +
  theme(axis.text.y=element_text(size=9),
        axis.title.y=element_text(size=25),
        axis.text.x=element_text(size=25),
        axis.title.x=element_text(size=25),
        plot.title=element_text(size=30,hjust=0.5)) +
  geom_text(aes(label=Contigs),hjust=-0.2,size=4)

ggsave("barplot_contigs.png",width=20, height=30)
