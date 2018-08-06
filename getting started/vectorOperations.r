x <- c(1,2,3,4,5,6,7,8,9,10)
x
x*3
x+2
x^2
sqrt(x)
log(x)

y <- -5:4
x + y 
x - y
x / y
x < y

x <- 10:1
y <- -4:5
x < y
any(x<y)
all(x<y)

q <- c("Hockey", "Football", "Curling", "Baseball", "Rugby", "Lacrosse",
      "Tennis", "Cricket", "Soccer")
q
nchar(q)

x[1]
x[1:2]
x[c(1,4)]

c(One="a", Two ="y", Last="r")

w <- 1:3
w
names(w) <- c("a", "b", "c")
w

q2 <- c(q, "Hockey", "Lacrosse", "Hockey", "Water Polo", "Lacrosse")
q2
q2Factor <- factor(q2)
q2Factor

z <- c(1,2,NA,9,3,NA)
is.na(z)
z <- c(1, NULL, 3)
z
is.na(z)
is.null(z)
d <- (NULL)
is.null(d)
