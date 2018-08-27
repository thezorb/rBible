library(ggplot2)
hist(diamonds$carat, main="Carat Histogram", xlab="carat")
plot(diamonds$carat, diamonds$price)
plot(price ~ carat, data=diamonds)
boxplot(diamonds$carat)

#ggplot2

#histogram
ggplot(data=diamonds)+geom_histogram(aes(x=carat))
ggplot(data=diamonds)+geom_histogram(aes(x=carat), binwidth=.1)

#density
ggplot(data=diamonds)+geom_density(aes(x=carat))
ggplot(data=diamonds)+geom_density(aes(x=carat), fill="grey50")

#scatterplot
ggplot(diamonds, aes(x=carat, y=price))+geom_point()
g <- ggplot(diamonds, aes(x=carat, y=price))
g + geom_point()
g + geom_point(aes(color=color))
g + geom_point(aes(color=color, shape=clarity))
g + geom_point(aes(color=color, shape=cut))

ggplot(diamonds, aes(y=carat,x=1))+geom_boxplot()
ggplot(diamonds, aes(y=carat,x=cut))+geom_boxplot()
ggplot(diamonds, aes(y=carat,x=cut))+geom_violin()

g <- ggplot(diamonds, aes(y=carat,x=cut))
g + geom_point() + geom_violin()
g + geom_violin() + geom_point()
g + geom_jitter() + geom_violin() 

#line plots
head(economics)
ggplot(economics, aes(x=date, y=pop)) + geom_line()

library(lubridate)
economics$year <- year(economics$date)
economics$month <- month(economics$date)
head(economics)
econ2000 <- economics[which(economics$year >= 2000),]
nrow(economics)
nrow(econ2000)
econ2000$month <- month(econ2000$date, label = TRUE)

library(scales)
g <- ggplot(econ2000, aes(x=month, y=pop))
g <- g + geom_line(aes(color=factor(year), group=year))
g <- g + scale_color_discrete(name="Year")
g <- g + scale_y_continuous(labels=comma)
g <- g + labs(title = "Population Growth", x="Month", y="Population")
g <- g + theme(axis.text.x=element_text(angle=90, hjust=1))
g

#small multiples
#faceting
g <- ggplot(diamonds, aes(x=carat, y=price))
g + geom_point(aes(color=color)) + facet_wrap(~color)
g + geom_point(aes(color=color)) + facet_grid(cut~clarity)
ggplot(diamonds, aes(x=carat)) + geom_histogram() + facet_wrap(~color)

#control colors and shapes
ggplot(diamonds, aes(x=carat, y=price, color=color, shape=cut, size=depth)) + geom_point()

#ggplot Themes
library(ggthemes)
g <- ggplot(diamonds, aes(x=carat, y=price, color=color)) + geom_point()
g
g + theme_wsj()
g + theme_economist() + scale_color_economist()
g + theme_tufte()
g + theme_excel() + scale_color_excel()
g + theme_fivethirtyeight()
