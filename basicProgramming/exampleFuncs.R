### below is code which will automatically be executed upon a 'source' command
x <- c(0.458, 1.6653, 0.83112)
percent <- round(x * 100, digits=1)
result <- paste(percent, "%", sep = " ")
print(result)

### code below is loaded upon a 'source' command but only executed when called
# function with single argument
addPercent <- function(x) {
  percent <- round(x * 100, digits = 1)
  result <- paste(percent, "%", sep = " ")
}
# multiple arguments
addPercent2 <- function(x, mult) {
  percent <- round(x * mult, digits = 1)
  result <- paste(percent, "%", sep = " ")
  return(result)
}
# if condition
priceCalculator <- function(hours, pph=40) {
  net.price <- hours * pph
  if(hours > 100) {
    print("in here")
    net.price <- net.price * 0.9
  }
  round(net.price)
}
# if/else conditions
priceCalculator2 <- function(hours, pph=40, public=TRUE) {
  net.price <- hours * pph
  if(hours > 100) net.price <- net.price * 0.9
  if(public) {
    tot.price <- net.price * 1.06
  } else {
    tot.price <- net.price * 1.12
  }
  round(tot.price)
}
# if used with vectors
priceCalculator3 <- function(hours, pph = 40, public) {
  net.price <- hours * pph
  net.price <- net.price * ifelse(hours > 100, 0.9, 1)
  tot.price <- net.price * ifelse(public, 1.06, 1.12)
  round(tot.price)
}
# nested if/else 
priceCalculator3a <- function(hours, pph = 40, client) {
    
    net.price <- hours * pph
  
    if (client == "private") {
      tot.price <- net.price * 1.12 
    } else {
      if(client == "public") {
        tot.price <- net.price * 1.06
      } else {
        tot.price <- net.price * 1
      }
    }
    round(tot.price)
}
# for loop
priceCalculator4 <- function(hours, pph = 40, client) {
  net.price <- hours * pph * ifelse(hours> 100, 0.9, 1)
  VAT <- numeric(0)
  for(i in client) {
    VAT <- c(VAT, switch(i, private = 1.12, public = 1.06, 1))
  }
  tot.price <- net.price * VAT
  round(tot.price)
}
# for loop with pre-allocated vector
#
####  please note, the code below is slightly different than in the slidedeck
####  slidedeck has an incorrect line within the for loop
#
priceCalculator5 <- function(hours, pph = 40, client) {
  net.price <- hours * pph * ifelse(hours > 100, 0.9, 1)
  nclient <- length(client)
  VAT <- numeric(nclient)
  for(i in seq_along(client)) {
    # print(i)
    VAT[i] <- switch(client[i], private = 1.12, public = 1.06, 1)
  }
  tot.price <- net.price * VAT
  round(tot.price)
}
# for loop replaced with sapply
priceCalculator6 <- function(hours, pph = 40, client) {
  net.price <- hours * pph * ifelse(hours > 100, 0.9, 1)
  
  VAT <- sapply(client, switch, private = 1.12, public = 1.06, 1)
  
  tot.price <- net.price * VAT
  round(tot.price)
}

#
