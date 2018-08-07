#Data Frames
x <- 10:1
y <- -4:5
q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby", "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")
theDF <- data.frame(x,y,q)
theDF
theDF <- data.frame(First = x, Second = y, Sport = q)
str(theDF)
class(theDF$Sport)

theDF <- data.frame(First = x, Second = y, Sport = q, stringsAsFactors = FALSE)
class(theDF$Sport)
dim(theDF)
NROW(theDF)
nrow(theDF)
nrow(x)
length(x)
NROW(x)
names(theDF)
names(theDF)[3]
rownames(theDF)
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
rownames(theDF)
theDF
rownames(theDF) <- NULL
rownmaes(theDF)
head(theDF)
tail(theDF)
class(theDF)

theDF$Sport
theDF[3, 2] #3rd row, 2nd column
theDF[3, 2:3] #3rd row, 2nd and 3rd column
theDF[c(3,5),2] #3rd and 5th row, 2nd column
theDF[c(2,4,5), c(1,2)]
theDF[,3]
theDF[1,]
theDF[,3,drop=FALSE]
theDF[,c("Sport","First")]
theDF[,"Sport", drop = FALSE]

#Lists
list1 <- list(1,2,3)
list1
list2 <- list(c(1,2,3))
list2

list3 <- list(c(1,2,3), 3:7)
list3

theDF <- data.frame(First=1:5, 
                    Second=5:1, 
                    Sport=c("Hockey","Lacrosse","Football",
                            "Curling","Tennis"),stringsAsFactors = FALSE)
theDF

list4 <- list(theDF, 1:10)
list4
list5 <- list(theDF, 1:10, list3)
list5
names(list5)
names(list5)  <- c("data.frame", "vector", "list")
list5
list6 <- list(TheDataFrame = theDF, TheVector = 1:10, TheList = list3)
list6
#creating an empty list
emptyList <- vector(mode="list", length=4)
emptyList
emptyList[[1]] <- 5
emptyList

list5[[1]]
names(list5)
list5[["data.frame"]]$Sport
list5[[1]][,"Second"]
list5[[1]][,"Second", drop=FALSE]
length(list5)
list5
list5[[4]]
list5[[4]] <- 2

#Matrices
A <- matrix(1:10, nrow=5)
A
B <- matrix(21:30, nrow=5)
B
C <- matrix(21:30, nrow=2)
C
nrow(A)
ncol(A)
dim(A)
A+B
A*B
A==B
ncol(A)
nrow(B)
t(B) #transpose the matrix
A %*% t(B) #dot product of A and transposed B
A %*% C
colnames(A)
rownames(A)
colnames(A) <- c("Left", "Right")
rownames(A) <- c("1st", "2nd", "3rd", "4th", "5th")
A
colnames(B) <- c("First", "Second")
rownames(B) <- c("One", "Two", "Three", "Four", "Five")

LETTERS
letters
colnames(C) <- LETTERS[1:5]
rownames(C) <- c("Top", "Bottom")
C

A
t(A)
A%*%C
