# Loading packages
library(xlsx)

# Reading the data
setwd("/home/guest/Traineeship/Scripts/STEP1/")
data <- read.xlsx("MycoGenomesFiltered.xlsx", 1, header=TRUE)

# Extracting the ftp URLs from the file
ftp_URL <- data$FTP.Path
write.table(x = ftp_URL, 
            file = "ftpURL.txt",
            sep = "\t",
            quote = FALSE,
            row.names = FALSE,
            col.names = FALSE)
