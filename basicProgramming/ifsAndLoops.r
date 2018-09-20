1 == 1
1 < 1
1 >= 1
1 <= 1
1 != 1

#basic if statement
toCheck <- 1
if(toCheck == 1)
{
  print("Hello!")
}

#if/else statement
check.bool <-function(x)
{
  if(x==1)
  {
    print("Hello")
  } else if(x==0)
  {
    print("Goodbye")
  } else 
  {
    print("Confused")
  }
}
check.bool(1)
check.bool(0)
check.bool("Hi")
check.bool(TRUE)
check.bool(FALSE)
check.bool(2)

#switch statements
use.switch <- function(x)
{
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "c"="third",
         "other")
}
use.switch("a")
use.switch("b")
use.switch("c")
use.switch("d")
use.switch(1)
use.switch(2)
use.switch(3)
use.switch(5)
use.switch(6)

#run checks on entire vectors
ifelse(1 == 1, "Yes", "No")
ifelse(1 == 0, "Yes", "No")

toTest <- c(1, 1, 0, 1, 0, 1)
ifelse(toTest == 1, "Yes", "No")
ifelse(toTest == 1, toTest*3, toTest)
ifelse(toTest == 1, toTest*3, "Zero")
toTest[2] <- NA
toTest
ifelse(toTest == 1, toTest*3, "Zero")

#compound statements
a <- c(1,1,0,1)
b <- c(2,1,0,1)
ifelse(a==1 & b==1, "Yes", "No")

#& and
#| or

x <- 1
y <- 2

if(x==0 && y==3) #with two &s, it'll only check the first statement
{
  print("Hello")
}

if(x==1 || y==3) #with two |s, it'll only check the first statement
{
  print("Hello")
}

ifelse(b==1, "Hi", ifelse(b==0, "Hello","Goodybe"))

#for loops
for(i in 1:10)
{
  print(i)
}

print(1:10)
fruit <- c("apple", "banana", "pomegranate")
fruitLength <- rep(NA, length(fruit))
fruitLength
names(fruitLength) <- fruit
fruitLength
for(a in fruit)
{
  fruitLength[a] <- nchar(a)
}
fruitLength
a

#let's do loops the R way
fruitLength2 <- nchar(fruit)
fruitLength2
names(fruitLength2) <- fruit
fruitLength2

#while loop
x <- 1
while(x <= 5)
{
  print(x)
  x <- x + 1
}

#control loops
for(i in 1:10)
{
  if(i==3)
  {
    next
  }
  print(i)
}

for(i in 1:10)
{
  if(i == 4)
  {
      break
  }
  print(i)
}
