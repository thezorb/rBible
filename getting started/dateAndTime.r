
# Dates
xd <- as.Date("2016-11-16")
print(xd)
weekdays(xd)
xd+7
xd + 0:6
weekdays(xd + 0:6)
xm <- seq(xd, by = "2 months", length.out = 6)
xm
months(xm)
quarters(xm)
nd <- "Nov 17, 2016"  # this line and below useful for data transforms
newdate <- as.Date(nd, format="%b %d, %Y")
paste("Original date: ",nd," Converted to R: ",newdate)  # useful for combining values for display
#
#
# Time
test <- "June 29, 1958, 20:17:39"
test.fmt <- "%B %d, %Y, %H:%M:%S"
xct = as.POSIXct(test, format=test.fmt, tz="UTC")
xct
format(xct, "%d/%m/%y")
format(xct, "%M minutes past %I %p, on %d %B %Y")
xct + 7*86400
xct + 3*60*60
xct - 7*86400
xct
