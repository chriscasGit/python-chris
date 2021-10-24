
library(readxl)
library(tidyverse)
library(ggplot2)

varvec <- list("MB", "WB", "MT", "WT")
pdf("rplot8.pdf") 
par(mfrow = c(2, 2))
df = br_size_check

for (i in varvec) {
varmfp = i
df1 <- df %>% filter(department == varmfp)
line1 <- as.numeric(quantile(df1$sku, na.rm = TRUE, 0.80))
line2 <- as.numeric(quantile(df1$sku, na.rm = TRUE, 0.60))
line3 <- as.numeric(quantile(df1$sku, na.rm = TRUE, 0.40))
line4 <- as.numeric(quantile(df1$sku, na.rm = TRUE, 0.20))
print(line1 + line2 + line3 + line4)

p <- ggplot(df1, aes(x=qty, y=sku, color=season, size=qty)) +
  geom_point()
print(p)
}

# Close the pdf file
dev.off() 
