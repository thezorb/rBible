large.islands <- head(sort(islands, decreasing = TRUE),10)
# if you receive a 'figure margins too large' error, make the plot area larger in bottom right
plot(large.islands, main="Land area of continents and islands ", ylab="Land area in square miles")
text(large.islands, labels=names(large.islands),adj=c(0.5,1))
#
plot(faithful)
short.eruptions <- with(faithful, faithful[eruptions < 3,])
#
plot(faithful)
# adding points to the plot, col=color, pch=plot character,19 - solid circle
points(short.eruptions,col="red",pch=19)
#
# create a regression model (using lm => linear regression model function)
#
fit <- lm(waiting ~ eruptions, data=faithful)
#
plot(faithful)

points(short.eruptions,col="red",pch=19)
#
# retrieve the the fitted values from model, using lines function to overlay onto plot
lines(faithful$eruptions, fitted(fit), col="blue")
# add (v)erticle line at  position eruptions == 3
abline(v=3, col="purple")
# add (h)orizontal line at the mean waiting time
abline(h = mean(faithful$waiting))
#
# Creating multiple plots together
# - par function returns original setting which can be reapplied once complete
old.par <- par(mfrow = c(1,2))
plot(faithful, main="Faithful eruptions")
plot(large.islands, main="Islands", ylab="Area")
par(old.par)
#
# Graphic displaying multiple sets of data - use of lattice package
#
str(mtcars)
transform.mtcars <- transform(mtcars, cyl=factor(cyl),
                                am=factor(am,labels=c("Automatic","Manual")),
                                cars=rownames(mtcars))
#
#
library("lattice")   # labeling differnt in lattice vs plot
#
#
xyplot(mpg ~ hp | cyl, data=transform.mtcars)
# add regression lines, p=points, r=regression
xyplot(mpg ~ hp | cyl, data=transform.mtcars,type=c("p","r"))
#
xyplot(mpg ~ hp | cyl, data=transform.mtcars,type=c("p","r"),
       main="Fuel Economy vs Performance", 
       xlab="Performance (horse power)",
       ylab="Fuel Economy (mpg)")
#
# different plots, barchart, scatterplot, etc
# cex = reduce character size by 50%, layout of 3 cols, 1 row
barchart(cars ~ mpg | cyl, data = transform.mtcars, main="barchart", scales=list(cex=0.5), layout = c(3,1))
#
# box&whisker (mean, quartile, whiskers)
bwplot(~hp | cyl, data=transform.mtcars, main="bwplot")
#
#
str(longley)
#
library("reshape2")
mlongley <- melt(longley, id.vars="Year")
str(mlongley) # 
mlongley
#
xyplot(value ~ Year | variable, data = mlongley, layout = c(6,1), par.strip.text = list(cex=0.5),
       scales = list(cex=0.5))
#
# more plotting
plot.colors <- c("grey80","grey20")
barchart(cars ~ mpg | cyl, data = transform.mtcars, main="barchart w/groups", group=am, auto.key=TRUE, 
         par.settings = simpleTheme(col=plot.colors, border=plot.colors), scales=list(cex=0.5), layout=c(3,1))
#
# showing invocation from script vs console
xyplot(mpg ~ hp | cyl, data = transform.mtcars)
# above works in command line, not in script (test to see if same behavior)
my.plot <- xyplot(mpg ~ hp | cyl, data = transform.mtcars)
print(my.plot)
#
# export to a file
setwd("~/Desktop")
trellis.device(device="png", filename="xyplot.png")
print(my.plot)
dev.off()
#
# use of ggplot2
#
install.packages("ggplot2")
library("ggplot2")
ggplot(faithful, aes(x=eruptions, y=waiting)) + geom_point() + stat_smooth()
#
ggplot(quakes, aes(x=depth)) + geom_histogram()
#
ggplot(quakes, aes(x=depth)) + geom_histogram(binwidth = 50)
#
ggplot(quakes, aes(x=long, y=lat)) + geom_point()
#
ggplot(longley, aes(x=Year, y=Unemployed)) + geom_line()
#
p <- ggplot(longley, aes(x=Year, y=Unemployed)) + geom_point()
p
p + stat_smooth()
p + stat_smooth(method="lm")
#
p <- ggplot(mtcars, aes(x=hp, y=mpg)) + geom_point()
p + stat_smooth(method="lm") + facet_grid(~cyl)
#
p <- ggplot(mtcars, aes(x=hp, y=mpg)) + geom_point(aes(shape = factor(cyl), colour = factor(cyl)))
p
p + scale_shape_discrete(name="Cylinders") + scale_colour_discrete(name="Cylinders")
#

