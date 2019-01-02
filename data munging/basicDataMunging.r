theMatrix <- matrix(1:9, nrow = 3)
theMatrix

#sum up columns
apply(theMatrix, MARGIN=2, sum)
colSums(theMatrix)
#sum up rows
apply(theMatrix, MARGIN=1, sum)
rowSums(theMatrix)

theMatrix[2,1] <- NA
theMatrix
apply(theMatrix, 1, sum)
apply(theMatrix, 2, sum)

#remove NAs
apply(theMatrix, 1, sum, na.rm = TRUE)
apply(theMatrix, 2, sum, na.rm = TRUE)

#lapply is versatile!
theList <- list(A=matrix(1:9, nrow=3), B=1:5, C=matrix(1:4,2), D=2)
theList
lapply(theList, sum) #returns a list
sapply(theList, sum) #tries to return a vector

theNames <- c("Jared", "Deb", "Paul")
lapply(theNames, nchar)
sapply(theNames, nchar)

#mapply for multiple lists
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16,4), B=matrix(1:16,8), C=15:1)
firstList
secondList

mapply(identical, firstList, secondList)

simplefunc <- function(x,y)
 {
   NROW(x) + NROW(y)
}

mapply(simplefunc, firstList, secondList)

#perform group summaries with the aggregate function
library(ggplot2)
data(diamonds)
head(diamonds)
mean(diamonds$price)
#calculation by field(s)
aggregate(price ~ cut, diamonds, mean)
aggregate(price ~ cut + color, diamonds, mean)
aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)

#group operations with plyr
#calculating OBP
require(plyr)
head(baseball)
#treating nulls
baseball$sf[baseball$year < 1954] <- 0 
any(is.na(baseball$sf))
baseball$hbp[is.na(baseball$hbp)] <- 0
any(is.na(baseball$hbp))

#only looking at at least 50 at bats (ab)
baseball <- baseball[baseball$ab >= 50,]

baseball$OBP <- with(baseball, (h + bb + hbp) / (ab + bb + hbp + sf))
tail(baseball)
#creating an obp function
obp <- function(data)
{
  c(OBP = with(data, sum(h + bb + hbp) / sum(ab + bb + hbp + sf)))
}
#split, apply, combine paradigm
careerOBP <- ddply(baseball, .variables="id", obp)
careerOBP <- careerOBP[order(careerOBP$OBP, decreasing=TRUE),]
head(careerOBP)
theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
theList
lapply(theList, sum)
sapply(theList, sum)

head(diamonds)
aggregate(price ~ cut, diamonds, each(mean,median))

numcolwise(sum, na.rm = TRUE)(diamonds)
sapply(diamonds[, sapply(diamonds, is.numeric)], sum)

#combine datasets
sport <- c("Hockey", "Baseball", "Football")
league <- c("NHL", "MLB", "NFL")
trophy <- c("Stanley Cup", "Comissioner's Trophy", "Vince Lombardi Trophy")
sports1 <- cbind(sport, league, trophy)
sports1
sports2 <- data.frame(sport=c("Basketball", "Golf"),
                      league=c("NBA", "PGA"),
                      trophy=c("Larry O'Brien Championship Trophy", "Wanamaker Trophy"))
sports2
sports <- rbind(sports1, sports2)
sports

#join datasets
head(countries)
head(codes)
countryMerged <- merge(x=codes, y=countries, by.x="Country.name", by.y="Country")
require(plyr) #in plyr column names have to have the same name
codes <- rename(codes, c(Country.name="Country"))
countryJoined <- join(x=codes, y=countries, by="Country")

#switch storage paradigms 
#moving from wide to long, long to wide
require(reshape2)
head(airquality)
airMelt <- melt(airquality, id=c("Month", "Day"),
                value.name ="Value", variable.name ="metric")
head(airMelt)

airCast <- dcast(airMelt, Month + Day ~ metric, value.var="Value")
airCast <- airCast[, c("Ozone", "Solar.R", "Wind", "Temp", "Month", "Day")]
head(airCast)

#tidyr
library(tidyr)
library(magrittr)

head(airquality)
airGather <- airquality %>% gather(Metric, Value, -c(Month, Day))
head(airGather)
tail(airGather)
airSpread <- airGather %>% spread(Metric, Value)
head(airSpread)
