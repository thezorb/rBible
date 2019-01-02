paste("hello", "Jared", "and others")
paste("hello", "Jared", "and others", sep ="/")
paste(c("Hello","Hey","Howdy"), c("Jared","Bob","David"))
paste("Hello", c("Jared","Bob","David"))
paste("Hello", c("Jared","Bob","David"), c("Goodbye", "Seeya"))

vectorOfText <- c("Hello", "everyone", "out there", ".")
paste(vectorOfText, collapse=" ")

person <- "Jared"
partySize <- 8
waitTime <- 25
paste("Hello ", person, ", your party of ", partySize, " will be seated in ", waitTime, " minutes.", sep = "")
sprintf("Hello %s, your party of %s will be seated in %s minutes.", person, partySize, waitTime)
