library(readxl)
library(tidyverse)
library(ggplot2)
library(tidyr)

#give pdf name
pdf("wf12.pdf") 

#define initial dataframe
df <- mfp_fym

#create columns
df <- df %>% separate("Time FYM", into = c('FY', 'FM'), sep = 4)
df$Department <- paste(df$`Material Gender`, "_", df$`Material Category`)
df$PG <- "SOUTH_RETAIL"

#create filters
years <- c(2019,2020,2021)
df <- filter(df, FY %in% years, 
             `Material Category` != "Accessories", 
             `Material Category` != "Footwear")

varpg <-list("SOUTH_RETAIL")
vardep <- unique(df$Department)
varmfp <- unique(df$`Material MFP Categorization`)

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
p <- ggplot(data=df1, aes(x=FM, y=Qty, fill=FY)) +
  geom_bar(position="dodge", stat="identity", width=0.7)+
  coord_flip()+
  theme(aspect.ratio = 8/3)+
   labs(title = i,#"South Retail: MFP Waterfall Evolution",
             subtitle = i,
             caption = "Christian C. 09/april/2021")
 print(p)
 
 
 p2 <- ggplot(data=df1, aes(x=FM, y=Qty, group=FY, colour=factor(FY))) + 
   geom_line(size=.75) + geom_point() +   
   theme(aspect.ratio = 3/5)
   #geom_text(aes(label = Qty,
  #           vjust = "inward", hjust = "inward",
  #           format_string='({:.1f}%)'
             
 print(p2)
 
}

##graph dept
varvec <- vardep
for (i in varvec) {
  
  #create subset df1
  df1 <- dfdep %>% filter(`Department` == i)
  
  #plot based on df1
  p <- ggplot(data=df1, aes(x=FM, y=Qty, fill=FY)) +
    geom_bar(position="dodge", stat="identity", width=0.7)+
    coord_flip()+
    theme(aspect.ratio = 8/3)+
    scale_y_continuous(limits = c(0,200000)) +
    labs(title = i,#"South Retail: MFP Waterfall Evolution",
         subtitle = i,
         caption = "Christian C. 09/april/2021")
  print(p)
  
  p2 <- ggplot(data=df1, aes(x=FM, y=Qty, group=FY, colour=factor(FY))) + 
    geom_line(size=.75) + geom_point() +   
    theme(aspect.ratio = 3/5)+
    scale_y_continuous(limits = c(0,200000)) +
  ylab("Volume")  
  print(p2)
  
}

dev.off() 

