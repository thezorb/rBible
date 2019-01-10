data("tips", package="reshape2")
head(tips)
unique(tips$sex)
unique(tips$day)
#t-tests
t.test(tips$tip, alternative="two.sided", mu=2.5)
require(ggplot2)
randT <- rt(30000, df=NROW(tips)-1)
tipTTest <- t.test(tips$tip, alternative="two.sided", mu=2.5)
ggplot(data.frame(x=randT)) + 
  geom_density(aes(x=x), fill="grey", color="grey") + 
  geom_vline(xintercept=tipTTest$statistic) + 
  geom_vline(xintercept=mean(randT) + c(-2,2) * sd(randT), linetype=2)

t.test(tips$tip, alternative="greater", mu=2.5)

aggregate(tip ~ sex, data=tips, mean)
aggregate(tip ~ sex, data=tips, var)
#shapiro test will tell us whether the data is normally distributed
shapiro.test(tips$tip)
shapiro.test(tips$tip[tips$sex == "Female"])
shapiro.test(tips$tip[tips$sex == "Male"])
ggplot(tips, aes(x=tip, fill=sex)) + geom_histogram(binwidth=.5, alpha=1/2)

ansari.test(tip ~ sex, tips)
t.test(tip ~ sex, data=tips, var.equal=TRUE)

require(plyr)
tipSummary <- ddply(tips, "sex", summarize, 
                    tip.mean=mean(tip), tip.sd=sd(tip),
                    Lower=tip.mean - 2*tip.sd/sqrt(NROW(tip)),
                    Upper=tip.mean + 2*tip.sd/sqrt(NROW(tip)))
tipSummary                    

ggplot(tipSummary,aes(x=tip.mean, y=sex)) + geom_point() + 
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=.2)
#If you can draw a straight line through the confidence intervals of two groups, it means the groups are pretty much equal in terms of distribution

library(UsingR)
head(father.son)
t.test(father.son$fheight, father.son$sheight, paired=TRUE)
#using ANOVA when you want to test for more than one value in a field
tipAnova <- aov(tip ~ day - 1, tips) # -1 here is important to get rid of the intercept! 
tipIntercept <- aov(tip ~ day, tips) 
tipAnova$coefficients
tipIntercept$coefficients

summary(tipAnova)
#visualizing ANOVA
tipsByDay <- ddply(tips, "day", summarize, 
                   tip.mean=mean(tip), tip.sd=sd(tip), 
                   Length=NROW(tip),
                   tfrac=qt(p=.90, df=Length-1),
                   Lower=tip.mean - tfrac*tip.sd/sqrt(Length), 
                   Upper=tip.mean + tfrac*tip.sd/sqrt(Length)
                   )

ggplot(tipsByDay, aes(x=tip.mean, y=day)) + geom_point() + 
  geom_errobarh(aes(xmin=Lower, xmax=Upper), height=.3)

