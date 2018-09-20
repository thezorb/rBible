theMatrix <- matrix(1:9, nrow = 3)
theMatrix

#sum up columns
apply(theMatrix, MARGIN=2, sum)
colSums(theMatrix)
#sum up rows
apply(theMatrix, MARGIN=1, sum)
rowSums(theMatrix)

theMatrix[2,1] <- NA
theMatrix
apply(theMatrix, 1, sum)
apply(theMatrix, 2, sum)

#remove NAs
apply(theMatrix, 1, sum, na.rm = TRUE)
apply(theMatrix, 2, sum, na.rm = TRUE)

#lapply is versatile!
theList <- list(A=matrix(1:9, nrow=3), B=1:5, C=matrix(1:4,2), D=2)
theList
lapply(theList, sum) #returns a list
sapply(theList, sum) #tries to return a vector

theNames <- c("Jared", "Deb", "Paul")
lapply(theNames, nchar)
sapply(theNames, nchar)

#mapply for multiple lists
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16,4), B=matrix(1:16,8), C=15:1)
firstList
secondList

mapply(identical, firstList, secondList)

simplefunc <- function(x,y)
 {
   NROW(x) + NROW(y)
}

mapply(simplefunc, firstList, secondList)

#perform group summaries with the aggregate function


