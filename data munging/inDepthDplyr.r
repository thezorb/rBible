data(diamonds, package = "ggplot2")
class(diamonds)
library(dplyr)
dia <- as.tbl(diamonds)
dia

#filtering
dia[,c('carat', 'price')]
dia %>% select(carat, price)
dia %>% select(1,7)
dia %>% select(-c(1,7))

dia %>% filter(cut == "Ideal")
dia %>% filter(cut == "Ideal", color == "E")
dia %>% filter(cut == "Ideal" & color == "E")
dia %>% filter(cut == "Ideal" | color == "E") #or
dia %>% filter(cut %in% c('Ideal','Premium'))

#slicing
dia %>% slice(1:5)
dia %>% slice(c(1,3,5:10))

#mutate or change columns
dia %>% mutate(ratio=price/carat)
dia

library(magrittr)
dia %<>% mutate(ratio=price/carat)
dia

#summarize
dia %>% summarize(mean(price))
dia %>% summarize(AvgPrice=mean(price))

#group by 
dia %>% group_by(cut) %>% summarize(AvgPrice=mean(price))
dia %>% group_by(cut, color) %>% summarize(AvgPrice=mean(price))
dia %>% group_by(cut) %>% summarize(AvgPrice=mean(price), AvgCarat=mean(carat), TotalCarat=sum(carat))
