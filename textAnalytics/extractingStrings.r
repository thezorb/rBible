require(XML)
theURL <- "http://www.loc.gov/rr/print/list/057_chron.html"
presidents <- readHTMLTable(theURL, which=3, as.data.frame=TRUE, skip.rows=1, header=TRUE, stringsAsFactors=FALSE)
head(presidents)
tail(presidents)
presidents <- presidents[1:64,]

library(stringr)
yearList <- str_split(string=presidents$YEAR, pattern="-")
head(yearList)
yearMatrix <- data.frame(Reduce(rbind, yearList))
head(yearMatrix)
names(yearMatrix) <- c("Start", "Stop")
head(yearMatrix)
presidents <- cbind(presidents, yearMatrix)
head(presidents)
tail(presidents)

str_sub(string=presidents$PRESIDENT, start=1, end=3)
str_sub(string=presidents$PRESIDENT, start=4, end=8)

presidents[str_sub(string=presidents$Start, start=4, end=4) == 1,
           c("YEAR", "PRESIDENT", "Start", "Stop")]

str_detect(presidents$PRESIDENT, "john")
str_detect(presidents$PRESIDENT, "John")
View(presidents[str_detect(presidents$PRESIDENT, "John"), ])


con <- url("http://www.jaredlander.com/data/warTimes.rdata")
load(con)
close(con)
head(warTimes,10)
warTimes[str_detect(string=warTimes, pattern="-")]
theTimes <- str_split(string=warTimes, pattern="(ACAEA)|-", n=2)
head(theTimes)

theStart <- sapply(theTimes, FUN=function(x) x[1])
head(theStart)
theStart <- str_trim(theStart)
head(theStart)

str_extract(string=theStart, pattern="January")
theStart[str_detect(string=theStart, pattern="January")]

head(str_extract(string=theStart, pattern="[0-9][0-9][0-9][0-9]"), 20)
head(str_extract(string=theStart, pattern="[0-9]{4}"), 20)

head(str_extract(string=theStart, "\\d{1,3}"), 20)
head(str_extract(theStart, "^\\d{4}"), 30)
head(str_extract(theStart, "^\\d{4}$"), 30)

head(str_replace(theStart, pattern="\\d", replacement="x"), 30)
head(str_replace_all(theStart, pattern="\\d", replacement="x"), 30)

commands <- c("<a href=index.html>The link is here</a>", 
              "<b>This is bold text</b>")
str_replace(string=commands, pattern="<.+?>(.+?)<.+>", replacement="\\1")
