library(readxl)
library(tidyverse)
library(ggplot2)
library(tidyr)

#give pdf name
pdf("wf7.pdf") 

#define initial dataframe
df <- mfp_fym

#create columns
df <- df %>% separate("Time FYM", into = c('FY', 'FM'), sep = 4)
df$Department <- paste(df$`Material Gender`, "_", df$`Material Category`)
df$PG <- "SOUTH_RETAIL"

#create filters
years <- c(2019,2020,2021,2022)
df <- filter(df, FY %in% years, 
             `Material Category` != "Accessories", 
             `Material Category` != "Footwear")

varpg <-list("SOUTH_RETAIL")
vardep <- unique(df$Department)
varmfp <- unique(df$`Material MFP Categorization`)
#varvec <- list("WB-700 SERIES-720")

#create Aggregate DFs
#df totals
dftot <- df %>% 
  group_by(PG, FY, FM) %>% 
  summarise(Qty = sum(`Sum of Qty Total`))
#view(dftot)

#df dep
dfdep <- df %>% 
  group_by(Department, FY, FM) %>% 
  summarise(Qty = sum(`Sum of Qty Total`))
#view(dfdep)

##graph total
varvec <- varpg
for (i in varvec) {
 
#create subset df1
df1 <- dftot %>% filter(`PG` == i)
 
#plot based on df1
p <- ggplot(data=df1, aes(x=FM, y=Qty, group=FY, color=FY)) +
   geom_line()+
   labs(title = i,#"South Retail: MFP Waterfall Evolution",
             subtitle = i,
             caption = "Christian C. 09/april/2021")
 print(p)
}

##graph dept
varvec <- vardep
for (i in varvec) {
  
  #create subset df1
  df1 <- dfdep %>% filter(`Department` == i)
  
  #plot based on df1
  p <- ggplot(data=df1, aes(x=FM, y=Qty, group=FY, color=FY)) +
    geom_line()+
    labs(title = i,#"South Retail: MFP Waterfall Evolution",
         subtitle = i,
         caption = "Christian C. 09/april/2021")
  print(p)
}


###graps###
# #graphs mfps
# for (i in varvec) {
# 
# #create subset df1
# df1 <- df %>% filter(`Material MFP Categorization` == i)
# 
# #plot based on df1
# p <- ggplot(data=df1, aes(x=FM, y=`Sum of Qty Total`, group=FY, color=FY)) +
#   geom_line()+
#   labs(title = i,#"South Retail: MFP Waterfall Evolution",
#             subtitle = i,
#             caption = "Christian C. 09/april/2021")
# print(p)
#}

dev.off() 

