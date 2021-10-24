library(readxl)
library(tidyverse)
library(ggplot2)

varvec <- list("MB", "WB", "MT", "WT")
pdf("rplot9.pdf") 
df = br_size_check_2

for (i in varvec) {
vardep = i
df1 <- df %>% filter(department == vardep)

p <- ggplot(data=df1, aes(x=sku_productivity, group=season, fill=season)) +
  geom_density(adjust=1.5, alpha=.4) +
  scale_y_continuous(labels = scales::percent)
  + labs(title = "South Retail: SKU productivity by Season/Department",
              subtitle = vardep,
              caption = "Christian C. 09/april/2021")

print(p)
}

dev.off() 

