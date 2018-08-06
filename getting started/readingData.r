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

