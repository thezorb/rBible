#date only
date1 <- as.Date("2012-05-23")
class(date1)
as.numeric(date1)

#date and time
date2 <- as.POSIXct("2012-06-28 17:42")
date2
class(date2)
as.numeric(date2)
