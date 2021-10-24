
library(readxl)
library(tidyverse)
library(ggplot2)
require("ggrepel")
options(ggrepel.max.overlaps = Inf)

varvec <- list("MB", "WB", "MT", "WT")
pdf("rplot8.pdf") 
#par(mfrow = c(2, 2))
df = br_size_check_2

for (i in varvec) {
varmfp = i
df1 <- df %>% filter(department == varmfp)

p <- ggplot(df1, aes(x=pc9_count, y=sku_count, color=season, size=qty, shape=season, ggtitle=department)) +
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)+
  geom_text_repel(aes(label = mfp), size = 1, box.padding=0.5)

p <- p + labs(title = "South Retail: SKU and PC9 counts by Season/MFP",
subtitle = varmfp,
caption = "Christian C. 09/april/2021")


print(p)
}


dev.off() 

