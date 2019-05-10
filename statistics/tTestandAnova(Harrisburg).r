# take a look at the data (32 observations)
str(mtcars)
#
sapply(mtcars, function(x) length(unique(x)))
# from the output, we do not see a vector with
# 32, so there are dupes
#
# 
cars <- transform(mtcars[c(1,2,9,10)], gear = ordered(gear),
  am= factor(am, labels = c("auto","manual")))
#
# show structure of the cars dataframe, only a few values instead of all
str(cars, vec.len=2)
#
# mpg, cylinders could be continuous variables, use function to help
mean(cars$mpg) # average
median(cars$cyl) # center
#
var(cars$mpg) # spread of data
sd(cars$mpg) # standard deviation
#
# quantiles
# 50% = median
#     = quantiles tell how much our data is above or below the median
# 0%  = min()
min(cars$mpg)
# 100% = max()
max(cars$mpg)
# range provides both
range(cars$mpg)
#
quantile(cars$mpg)
# Quartiles are the 25% and 75% quantiles, 
# which is where the data is all one-fourth and 
# three-fourths smaller
#
# frequency table
#
amtable <- table(cars$am)
amtable
class(amtable)
#
# compute the proportion of each count (two ways)
amtable/sum(amtable)
prop.table(amtable)
#
# histograms
hist(cars$mpg, col="grey")
hist(cars$mpg, col="grey", 6) # can define number of columns
hist(cars$mpg, breaks=c(5,15,25,35)) # specify breaks
#
# probability density
#
mpgdens <- density(cars$mpg)
plot(mpgdens)
hist(cars$mpg, col="grey", freq=FALSE)
lines(mpgdens)
#
# get a summary of your data
summary(cars)
#
# convert cylinder to factor
cars$cyl <- as.factor(cars$cyl)
summary(cars)
#
boxplot(mpg ~ cyl, data = cars)
# 
# assigning the output of plotting data
mpghist <- hist(cars$mpg)
mpghist
#
# more plotting use
mpgbox <- boxplot(mpg ~ cyl, data = cars)
n <- nlevels(as.factor(cars$cyl))
text(1:n, mpgbox$stats[1, ], paste("n=", mpgbox$n), pos = 1)
#
# scratching the surface above, investigate further online or in help
#
# correlations
names(iris)
plot(iris[-5])
#
with(iris, cor(Petal.Width, Petal.Length))
#
iris.cor <- cor(iris[-5])
str(iris.cor)
iris.cor["Petal.Width", "Petal.Length"]
#
# tables
with(cars, table(am, gear))
#
# tables from matrix
trial <- matrix(c(34,11,9,32), ncol=2)
colnames(trial) <- c("Sick","Healthy")
rownames(trial) <- c("Risk","No_Risk")
trial.table <- as.table(trial)
trial.table
# 
# data frame from matrix
trial.df <- as.data.frame(trial)
str(trial.df)
# df from table
# convert of table gives more useful information for analysis
trial.table.df <- as.data.frame(trial.table)
str(trial.table.df)
#
# adding margins (all, column, row)
addmargins(trial.table)
addmargins(trial.table, margin=2) # row
addmargins(trial.table, margin=1) # col
#
# calculating proportions
trial.table
prop.table(trial.table)
prop.table(trial.table, margin = 1)
prop.table(trial.table, margin = 2)
#
# statistical functions
#
# continue from here next week...
# 
str(beaver2)
transform.beaver <- transform(beaver2, 
                              activ = factor(activ, 
                                             labels=c("no","yes"))
)
str(transform.beaver)
#
# using lattice library 
library("lattice")
histogram(~temp | activ, data=transform.beaver)
#
# quantile plot, plot quantiles against each other using qqplot
# note example below slightly different than the slides
#
with(transform.beaver, qqplot(temp[activ=="yes"], temp[activ=="no"]))
with(transform.beaver, {qqnorm(temp[activ=="no"], main = "Inactive")})
with(transform.beaver, qqline(temp[activ=="no"]))
with(transform.beaver, {qqnorm(temp[activ=="yes"], main = "Active")})
with(transform.beaver, qqline(temp[activ=="yes"]))
#
# testing for p-value (level of the probability of uncertainty)
# (shapiro-wilks test)
shapiro.test(transform.beaver$temp)
#
# capture results to get only p-value
result <- shapiro.test(transform.beaver$temp)
result$p.value
#
# checking for normality
with(transform.beaver,tapply(temp,activ, shapiro.test))
#
# start tests for comparing two groups with numerical data
# t-test, Wilcoxon test
# t-test requires sample to be normally distributed
# Wilcoxon does not
#
# t.test()
t.test(temp ~ activ, data=transform.beaver)
# wilcox.text()
wilcox.test(temp ~ activ, data=transform.beaver)
#
# testing paired data
#
t.test(extra ~ group, data=sleep,  paired=TRUE)
#
#
# Proportions
#
survivors <- matrix(c(1781, 1443, 135, 47), ncol = 2)
colnames(survivors) <- c("survived", "died")
rownames(survivors) <- c("no seat belt", "seat belt")
survivors
#
# conduct proportion test to calculate probability both proportions
# are the same
# a low p-value tells that both proportions differ from each other
#
result.prop <- prop.test(survivors)
result.prop
# another test available chi-squared test
chisq.test(survivors)
#
# test tables with more than two columns
#
str(HairEyeColor)
#
HairEyeMargin <- margin.table(HairEyeColor, margin = c(1,2))
HairEyeMargin
chisq.test(HairEyeMargin)
#
#
#  Modeling
#
# Analyzing variances (anova)
str(InsectSprays)
# build model and take a look at the info
AOVModel <- aov(count ~ spray, data = InsectSprays)
AOVModel
# Summary of the model
#
summary(AOVModel)
# 
# get more detail using the model.tables function
model.tables(AOVModel, type = "effects")
#
# can do comparisons of the model data
#
Comparisons <- TukeyHSD(AOVModel)
Comparisons$spray["D-C",]
#
# plot comparisons
# - if confidence interval doesn't include zero, diff between is high
plot(Comparisons, las=1) # las=1 prints horizontally
#
# Using linear models for variance analysis
#
# lm() takes 2 args, the formula which describes model, and dataframe 
# with variables in formula
Model <- lm(mpg ~ wt, data = mtcars)
#
# get data using coef() 
coef.Model <- coef(Model)
coef.Model # contains the intercept and slope
#
# plot information
plot(mpg ~ wt, data = mtcars)
abline(coef = coef.Model)
#
Model.summary <- summary(Model)
Model.summary

