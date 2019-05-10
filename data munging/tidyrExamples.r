# tidy data code
install.packages("tidyr")
install.packages("magrittr")
install.packages("tidyverse")

#
library(magrittr) # required for piple 
library(tidyr)
library(dplyr)  
#
# create 'messy' dataframe
messy <- data.frame( name=c("Wilbur","Petunia","Gregory"), 
                     a = c(67,80,64),
                     b = c(56,90,50)
                     )
messy
#
filteredData <- filter(airquality,airquality$Month != 5)
filteredData
groupedData <- group_by(filteredData, Month)
groupedData
summarise(groupedData, mean(Temp, na.rm=TRUE))
# example use of pipe redirect
airquality %>% 
  filter(Month != 5) %>% 
  group_by(Month) %>% 
  summarize(mean(Temp, na.rm=TRUE))
#
messy %>% gather(drug, heartrate, a:b)
#
#
set.seed(10)
messy <- data.frame(
  id = 1:4,
  trt = sample(rep(c('control', 'treatment'), each = 2)),
  work.T1 = runif(4),
  home.T1 = runif(4),
  work.T2 = runif(4),
  home.T2 = runif(4)
)
messy
tidier <- messy %>% gather(key, time, -id, -trt)
#
tidier
tidy <- tidier %>% separate(key, into=c("location","time"), sep="\\.")
tidy %>% head(8)
#
head(airquality)
#
filter(airquality, Temp > 70)
#
filter(airquality, Temp > 80 & Month > 5)
#
mutate(airquality, TempInC = (Temp - 32) * 5/9)
#
# using group_by to group data
summarise(group_by(airquality, Month), mean(Temp, na.rm = TRUE))
#
# sample function takes random rows from a table
sample_n(airquality, size = 10)
sample_frac(airquality, size = 0.1)
#
count(airquality, Month)
# arrange rows by variable
arrange(airquality, desc(Month), Day)
#
tmp <- arrange(airquality, desc(Month), Day)
tmp
# more examples...
#
library(dplyr)
# From http://stackoverflow.com/questions/1181060
stocks <- data_frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
# show of the data
stocks
#
# gather function supply dataframe
gather(stocks, stock, price, -time)
#
# using pipe
stocks %>% gather(stock, price, -time)
#
# more examples of gather
#
# get first observation for each Species in iris data -- base R
mini_iris <- iris[c(1, 51, 101), ]
mini_iris
#
# gather Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
gather(mini_iris, key = flower_att, value = measurement,
       Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
#
# same result but less verbose (just exclude Species)
#
gather(mini_iris, key = flower_att, value = measurement, -Species)
# repeat iris example using dplyr and the pipe operator
#
library(dplyr)
mini_iris <-
  iris %>%
  group_by(Species) %>%
  slice(1)
mini_iris
#
mini_iris %>% gather(key = flower_att, value = measurement, -Species)
#
# use of separate
#
library(dplyr)
df <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df
#
df %>% separate(x, c("A", "B"))
#
# If every row doesn't split into the same number of pieces, use
# the extra and fill arguments to control what happens
#
df <- data.frame(x = c("a", "a b", "a b c", NA))
#
df %>% separate(x, c("a", "b"))
# The same behaviour but no warnings
df %>% separate(x, c("a", "b"), extra = "drop", fill = "right")
# Another option:
df %>% separate(x, c("a", "b"), extra = "merge", fill = "left")
# If only want to split specified number of times use extra = "merge"
df <- data.frame(x = c("x: 123", "y: error: 7"))
df
df %>% separate(x, c("key", "value"), ": ", extra = "merge")
#
#
vignette("tidy-data")
