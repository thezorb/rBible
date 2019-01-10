 rnorm(10) #normal distribution of 10 numbers
rnorm(10, mean=100, sd=20) 
randNorm10 <- rnorm(10)
randNorm10
dnorm(randNorm10) #probability of these numbers occuring
dnorm(c(-1,0,1))

require(ggplot2)
randNorm <- rnorm(30000)
randDensity <- dnorm(randNorm)
ggplot(data.frame(x=randNorm, y=randDensity)) + aes(x=x, y=y) + 
  geom_point() +
  labs(x="Random Variables", y="Density")

pnorm(randNorm10)
pnorm(c(-3, 0, 3)) #left tail probability
pnorm(1) - pnorm(0)

randNorm10
pnorm(randNorm10)
qnorm(pnorm(randNorm10))

rbinom(n=1, size=10, prob=0.4)
rbinom(n=5, size=10, prob=0.4)
rbinom(n=10, size=10, prob=0.4)
rbinom(n=1, size=1, prob=0.4)

binomData <- data.frame(Success=rbinom(n=10000, size=10, prob=0.3))
ggplot(binomData, aes(x=Success)) + geom_histogram(binwidth=1)

binom5 <- data.frame(Successes=rbinom(n=10000, size=5, prob=0.3), Size=5)
head(binom5)
binom10 <- data.frame(Successes=rbinom(n=10000, size=10, prob=0.3), Size=10)
binom100 <- data.frame(Successes=rbinom(n=10000, size=100, prob=0.3), Size=100)
binom1000 <- data.frame(Successes=rbinom(n=10000, size=1000, prob=0.3), Size=1000)
binomAll <- rbind(binom5, binom10, binom100, binom1000)
head(binomAll)
tail(binomAll)
ggplot(binomAll, aes(x=Successes)) + geom_histogram() + facet_wrap(~Size, scales="free")

dbinom(x=3, size=10, prob=0.3)
pbinom(q=3, size=10, prob=0.3)
qbinom(p=0.3, size=10, prob=0.3)
qbinom(p=c(.3, .35, .4, .5, .6), size=10, prob=0.3)

pois1 <- rpois(n=10000, lambda=1)
pois2 <- rpois(n=10000, lambda=2)
pois5 <- rpois(n=10000, lambda=5)
pois10 <- rpois(n=10000, lambda=10)
pois20 <- rpois(n=10000, lambda=20)

pois <- data.frame(Lambda.1=pois1, Lambda.2=pois2, Lambda.5=pois5, Lambda.10=pois10, Lambda.20=pois20)
head(pois)

require(reshape2)
pois <- melt(data=pois, variable.name="Lambda", value.name="x")
head(pois)
tail(pois)
require(stringr)
pois$Lambda <- str_extract(string=pois$Lambda, pattern="\\d+")
head(pois)
class(pois$Lambda)
pois$Lambda <- as.factor(as.numeric(pois$Lambda))
tail(pois)

ggplot(pois, aes(x=x)) + 
  geom_density(aes(group=Lambda, color=Lambda, fill=Lambda), adjust=4, alpha=1/2) + 
  scale_color_discrete() + scale_fill_discrete() +
  ggtitle("Probability Mass function")

x <- sample(x=1:100, size=100, replace=TRUE)
x
mean(x)
#removing nulls while calculating averages
y<-x
y[sample(x=1:100, size=20, replace=FALSE)] <- NA
mean(y)
mean(y,na.rm=TRUE)

#weighted averages
grades <- c(95, 72, 87, 66)
weights <- c(1/2, 1/4, 1/8, 1/8)
mean(grades)
weighted.mean(x=grades, w=weights)

#variance: how spread out the data is? smaller variance, closer the values are to the center
var(x)
mean(x)
sum((x-mean(x))^2)/(length(x)-1)
sqrt(var(x))
sd(x)
sd(y)
sd(y,na.rm=TRUE)

summary(x)
summary(y)

quantile(x, probs=c(.25,.75))
quantile(x, probs=c(.1, .25, .5, .75, .92))

require(ggplot2)
cor(economics$pce, economics$psavert)
cor(economics[, c(2, 4:6)])
econCor <- cor(economics[, c(2, 4:6)])
require(reshape2)
econMelt <- melt(econCor, varnames=c("x", "y"), value.name = "Correlation")
econMelt <- econMelth[order(econMelt$Correlation), ]
econMelt
require(scales)
ggplot(econMelt, aes(x=x, y=y)) + 
  geom_tile(aes(fill=Correlation)) + 
  scale_fill_gradient2(low=muted("red"), mid="white", high="steelblue", 
                       guide=guide_colorbar(ticks=FALSE, barheight=10),
                       limits=c(-1,1)) + 
  theme_minimal() + labs(x=NULL, NULL)


m <- c(9, 9, NA, 3, NA, 5, 8, 1, 10, 4)
n <- c(2, NA, 1, 6, 6, 4, 1, 1, 6, 7)
p <- c(8, 4, 3, 9, 10, NA, 3, NA, 9, 9)
q <- c(10, 10, 7, 8, 4, 2, 8, 5, 5, 2)
r <- c(1, 9, 7, 6, 5, 6, 2, 7, 9, 10)
theMat <- cbind(m, n, p, q, r)
theMat
cor(theMat)
cor(theMat, use="everything")
cor(theMat, use="all.obs")
cor(theMat, use="complete.obs")
theMat
cor(theMat, use="na.or.complete")

