#basics

max(x,na.rm=TRUE) #Find the maximum value in the vector x, exclude missing values 
min(x, na.rm=TRUE) 
mean(x,na.rm=TRUE) 
median(x,na.rm=TRUE) 
sum(x, na.rm=TRUE) 
var(x,na.rm=TRUE) #produces the variance covariance matrix 
sd(x,na.rm=TRUE) #standard deviation 
mad(x,na.rm=TRUE) #(median absolute deviation) 
fivenum(x,na.rm=TRUE) #Tukey five numbers min, lower hinge, median, upperhinge, max 
table(x) #frequency counts of entries, ideally the entries are factors (although it works with integers or even reals) 

abs(x) #takes the absolute value of x
log(x,base = y) #Takes the log of x with base y; if base is not specified, returns the natural log
exp(x) #returns the exponential of x
sqrt(x) #Returns the square root of x
factorial(x) #Returns the factorial of x (x!)
choose(x, y) #Returns the number of possible combinations when drawing y elements at a time from x possibilities
round(x, digits = y) #Rounds x to y places
floor(x) #rounds down to the nearest int
ceiling(x) #rounds up to the nearest int
signif(x, digits = y) #rounds to that specified number of significant digits
