# Loading packages
library(xlsx)
library(ggplot2)
library(RColorBrewer)

# Loading data
setwd("/home/guest/Traineeship/Scripts/STEP2/")
data <- read.xlsx("MycoGenomesFilteredBUSCO.xlsx",1,header=TRUE)

#boxplot(data$Size..Mb.)
ggplot(data,aes(x=factor(0), y=Size..Mb., fill=factor(0))) +
  geom_boxplot() +
  ggtitle("Mycobacterial genome sizes") +
  scale_fill_manual(values="#EBC4F6") +
  scale_y_continuous(limits=c(2,10), expand=c(0,0)) +
  ylab("Size in Mb") +
  theme(
    axis.text.x=element_blank(),
    axis.title.x=element_blank(),
    axis.ticks.x=element_blank(),
    plot.title=element_text(size=15,hjust=0.5),
    legend.position = "none")

ggsave("boxplot_GenoSize.png",width=5, height=5) 

