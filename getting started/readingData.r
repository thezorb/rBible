#read CSV
newCSV <- read.csv("filename.csv", header = TRUE)

#read text file
require(readr)
readTXT <- read.table("filename.txt",header = TRUE,sep = ";")

#read Excel v1
library(readxl)
readExcel <- read_excel("filename.xlsx")

#read Excel v2
require(gdata)
df = read.xls ("myfile.xlsx"), sheet = 1, header = TRUE)

#Other examples from Jared Lander's lectures

#Reading CSV
"http://www.jaredlander.com/data/Tomato%20First.csv"

tomato <- read.table(file="http://www.jaredlander.com/data/Tomato%20First.csv", header=TRUE, sep=",")
head(tomato)
class(tomato$Tomato)
tomato <- read.table(file="http://www.jaredlander.com/data/Tomato%20First.csv", header=TRUE, sep=",",stringsAsFactors = FALSE)
class(tomato$Tomato)
sep="\t"
sep=";"

#Reading Excel
download.file('http://www.jaredlander.com/data/ExcelExample.xlsx', destfile='ExcelExample.xlsx',mode='wb')
library(readxl)
tomatoXL <- read_excel('ExcelExample.xlsx', sheet=1)
head(tomatoXL)

wineXL <- read_excel('ExcelExample.xlsx', sheet = 'Wine')
head(wineXL)

library(openxlsx)
tomatoXL1 <- read.xlsx('ExcelExample.xlsx', sheet=1)
head(tomatoXL1)

#data included in R
require(ggplot2)
data(diamonds)
head(diamonds)

data("tips", package="reshape2")
head(tips)

data()

#XML
library(XML)
library(httr)
theURL <- GET("http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/")
bowlGame <- readHTMLTable(rawToChar(theURL$content), which=1, header=FALSE, stringsAsFactors=FALSE)
bowlGame

#the rest doesn't work that great
address <- "http://www.menupages.com/restaurants/fiores-pizza/menu"
thePage <- readLines(address)
head(thePage)

pageRender <- htmlParse(thePage)
pageRender

address <- xpathApply(pageRender, "//li[@class='address adr']/span[@class='addr street-address']",fun-xmlValue)[[1]]



