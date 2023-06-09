### Statistical testing

## Correlation between absence/presence of plasmid and clinical relevance
present <- c(17,14)
absent <- c(67,52)
result1 <- data.frame(present,
                     absent,
                     row.names=c("Yes","Not reported/unclear"))
fisher.test(result1)

## Correlation between absence/presence of plasmid and growth
present <- c(14,17)
absent <- c(56,60)
result2 <- data.frame(present,
                      absent,
                      row.names=c("Slow","Rapid"))
fisher.test(result2)
