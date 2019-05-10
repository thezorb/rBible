## --------------------------------------------------------------------
## Introductory text mining script and some advanced mapping examples
## Thanks to https://rstudio-pubs-static.s3.amazonaws.com/31867_8236987cf0a8444e962ccd2aec46d9c3.html
## --------------------------------------------------------------------

#Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc")
Needed <- c("tm", "SnowballCC", "RColorBrewer", "wordcloud", "biclust", "cluster", "igraph", "fpc")

install.packages(Needed, dependencies=TRUE)

install.packages("Rcampdf", repos = "http://datacube.wu.ac.at/", type = "source")

##########################################################################################
#                                  Loading Texts                                         #
##########################################################################################
#
#     Start by saving your text files in a folder titled:    "texts"
#     This will be the "corpus" (body) of texts you are mining.
#
#     Next, choose the type of computer you have...

######
# **On a Mac**, save the folder to your *desktop* and use the following code chunk:
######
cname <- file.path("~", "Desktop/R-Work/Data/", "texts")
cname
dir(cname)   # Use this to check to see that your texts have loaded.

######
# *On a PC*, save the folder to your *C: drive* and use the following code chunk:
######
#cname <- file.path("C:", "texts")
#cname
#dir(cname)
##########################################################################################
##########################################################################################

##########################################################################################
#                                Start Your Analyses                                     #
##########################################################################################
# **Load the R package for text mining and then load your texts into R.**
library(tm)
docs <- Corpus(DirSource(cname))
## Preprocessing
docs <- tm_map(docs, removePunctuation)   # *Removing punctuation:*
docs <- tm_map(docs, removeNumbers)      # *Removing numbers:*
docs <- tm_map(docs, tolower)   # *Converting to lowercase:*
docs <- tm_map(docs, removeWords, stopwords("english"))   # *Removing "stopwords"

library(SnowballC)
docs <- tm_map(docs, stemDocument)   # *Removing common word endings* (e.g., "ing", "es")
docs <- tm_map(docs, stripWhitespace)   # *Stripping whitespace
docs <- tm_map(docs, PlainTextDocument)
## *This is the end of the preprocessing stage.*

### Stage the Data
dtm <- DocumentTermMatrix(docs)
dtm
tdm <- TermDocumentMatrix(docs)
tdm
### Explore your data
freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq)
m <- as.matrix(dtm)
dim(m)
write.csv(m, file="~/Desktop/DocumentTermMatrix.csv")
### FOCUS - on just the interesting stuff...
#  Start by removing sparse terms:
dtms <- removeSparseTerms(dtm, 0.10) # This makes a matrix that is 10% empty space, maximum.
### Word Frequency
head(table(freq), 20)
# The above output is two rows of numbers. The top number is the frequency with which
# words appear and the bottom number reflects how many words appear that frequently.
#
tail(table(freq), 20)

# Considering only the 20 greatest frequencies
#
# **View a table of the terms after removing sparse terms, as above.
freq <- colSums(as.matrix(dtms))
freq
# The above matrix was created using a data transformation we made earlier.
# **An alternate view of term frequency:**
# This will identify all terms that appear frequently (in this case, 50 or more times).
findFreqTerms(dtm, lowfreq=50)   # Change "50" to whatever is most appropriate for your data.
#
### Plot Word Frequencies
# **Plot words that appear at least 10 times.**
library(ggplot2)
wf <- data.frame(word=names(freq), freq=freq)
p <- ggplot(subset(wf, freq>500), aes(word, freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p
#
### Word Clouds!
# First load the package that makes word clouds in R.
library(wordcloud)
dtms <- removeSparseTerms(dtm, 0.15) # Prepare the data (max 15% empty space)
freq <- colSums(as.matrix(dtm)) # Find word frequencies
dark2 <- brewer.pal(6, "Dark2")
wordcloud(names(freq), freq, max.words=100, rot.per=0.2, colors=dark2)
wordcloud(names(freq), freq, max.words=50, rot.per=0.2, colors=dark2)
wordcloud(names(freq), freq, max.words=25, rot.per=0.2, colors=dark2)

### Clustering by Term Similarity

### Hierarchal Clustering
dtmss <- removeSparseTerms(dtm, 0.15) # This makes a matrix that is only 15% empty space.
inspect(dtmss)
library(cluster)
d <- dist(t(dtmss), method="euclidian")   # First calculate distance between words
fit <- hclust(d=d, method="ward.D2")
plot.new()
plot(fit, hang=-1)
groups <- cutree(fit, k=6)   # "k=" defines the number of clusters you are using
rect.hclust(fit, k=6, border="red") # draw dendogram with red borders around the 5 clusters
#
#
library(fpc)
d <- dist(t(dtmss), method="euclidian")
kfit <- kmeans(d, 2)
clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0)

## ------------------------------------------
## mapping Earthquake Activity
## 

#Spatial Analysis with R
#Basic Tutorial

library(sp)
library(plotrix)
library(raster)
library(rgdal)
library(rgeos)

## Set the working directory to where you want the
## output files to be stored.
##setwd("C:/Visualize Earthquake")

#http://earthquake.usgs.gov/earthquakes/feed/v1.0/csv.php
#From this address we can download csv files with locations of Earthquakes
#For this experiment we will download the summary of the last 30 days
#This dataset is updated every 15 minutes so your output may differ from the following

URL <- "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
Earthquake_30Days <- read.table(URL, sep = ",", header = T)

#Check the data.frame dimensions
nrow(Earthquake_30Days)
ncol(Earthquake_30Days)

#We can check the contents of the table with the following function
str(Earthquake_30Days)

#The function names() is used to generate a list of the column names of a data.frame
names(Earthquake_30Days)

#Now we can transform the data.frame into a Spatial object
coordinates(Earthquake_30Days)=~longitude+latitude
str(Earthquake_30Days)

#Slot data
str(Earthquake_30Days@data)

#Check and set the projection
Earthquake_30Days@proj4string

#We can set the projection to WGS84 using the following line
projection(Earthquake_30Days)=CRS("+init=epsg:4326")
#http://spatialreference.org/ref/epsg/wgs-84/

#Downloading polygons with the border of each country
#Download, unzip and load the polygon shapefile with the countries' borders
download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip",destfile="TM_WORLD_BORDERS_SIMPL-0.3.zip")
unzip("TM_WORLD_BORDERS_SIMPL-0.3.zip",exdir=getwd())
polygons <- shapefile("TM_WORLD_BORDERS_SIMPL-0.3.shp")

#Let us check the time variable
Earthquake_30Days$time[1]

#The time variable has the following format: year-month-dayThour:minutes:second.milliseconds
#Now that we understood the format we can change this variable from a factor to a time stamp

conv.time <- function(vector){
  split1 <- strsplit(paste(vector),"T")
  split2 <- strsplit(split1[[1]][2],"Z")
  fin <- paste0(split1[[1]][1],split2[[1]][1])
  paste(as.POSIXlt(fin,formate="%Y-%m-%d%H:%M:%OS3"))
}

conv.time(Earthquake_30Days$time[1])

DT <- sapply(Earthquake_30Days$time,FUN=conv.time)

Earthquake_30Days$DateTime <- as.POSIXlt(DT)

#####################################
#Plot Color:Days - Size:Magnitude
#Color Scale
days.from.today <- round(c(Sys.time()-Earthquake_30Days$DateTime)/60,0)
colour.scale <- color.scale(days.from.today,color.spec="rgb",extremes=c("red","blue"),alpha=0.5)
colors.DF <- data.frame(days.from.today,color.scale(days.from.today,color.spec="rgb",extremes=c("red","blue")))
colors.DF <- colors.DF[with(colors.DF, order(colors.DF[,1])), ]
colors.DF$ID <- 1:nrow(colors.DF)
breaks <- seq(1,nrow(colors.DF),length.out=10)

#Size scale
size.DF <- data.frame(Earthquake_30Days$mag,Earthquake_30Days$mag/5)
size.DF <- size.DF[with(size.DF, order(size.DF[,1])), ]
size.DF$ID <- 1:nrow(size.DF)
breaks.size <- seq(0,max(na.omit(Earthquake_30Days$mag/5)),length.out=5)

#Save plot in JPEG
tiff(filename="~/Desktop/Earthquake_Map.tif",width=7000,height=4000, res=300)
#Plot
plot(polygons)
plot(Earthquake_30Days, col= colour.scale, cex=Earthquake_30Days$mag/5, pch=16, add=T)

#Title and Legend
title("Earthquakes in the last 30 days",cex.main=3)
legend.pos <- list(x=-28.52392,y=-20.59119)
rect(xleft=legend.pos$x-5, ybottom=legend.pos$y-30, xright=legend.pos$x+30, ytop=legend.pos$y+10, col="white", border=NA)
legend(legend.pos,legend=c(round(colors.DF[colors.DF$ID %in% round(breaks,0),1],2)),fill=paste(colors.DF[colors.DF$ID %in% round(breaks,0),2]),bty="n",bg=c("white"),y.intersp=0.75,title="Depth",cex=0.8) 
text(x=legend.pos$x+5,y=legend.pos$y+5,"Legend:")
legend(x=legend.pos$x+15,y=legend.pos$y,legend=breaks.size[2:5]*5,pch=points(rep(legend.pos$x+15,4),c(legend.pos$y-6,legend.pos$y-9,legend.pos$y-12,legend.pos$y-15),pch=16,cex=breaks.size[2:5]),cex=0.8,bty="n",bg=c("white"),y.intersp=1.1,title="Magnitude")

dev.off()

## plot the results on screen
plot(polygons)
plot(Earthquake_30Days, col= colour.scale, cex=Earthquake_30Days$mag/5, pch=16, add=T)

## ---------------------------------------------------
## ADVANCED Data Analysis
## Cluster Analysis - USGS Earthquake Data
## http://www.r-bloggers.com/cluster-analysis-on-earthquake-data-from-usgs/
