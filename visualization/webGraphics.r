library(ggvis)
library(ggplot2)
library(ggthemes)

data("cocaine")
head(cocaine)

ggplot(cocaine, aes(x=weight, y=price)) + geom_point()

cocaine %>% ggvis(x=~weight, y=~price) %>% layer_points()
cocaine %>% ggvis(x=~weight, y=~price, fill=~potency) %>% layer_points() 
cocaine %>% ggvis(x=~weight, y=~price, stroke=~potency) %>% layer_points() 
cocaine %>% ggvis(x=~weight, y=~price, fill:="green", stroke:="white") %>% layer_points() 


cocaine %>% ggvis(x=~weight, y=~price, fill=~potency) %>% layer_points() %>% layer_smooths()
#interactive buttons
cocaine %>% ggvis(~weight, ~price, fill=~potency, size:=input_slider(10,100), 
                  opacity:=input_slider(0,1)) %>% layer_points()

ggplot(cocaine,aes(x=price)) + geom_histogram()
cocaine %>% ggvis(~price) %>% layer_histograms()

#rCharts
#ramnathv.github.io/rCharts
library(devtools)
install_github("rCharts", "ramnathv")
library(rCharts)
head(iris)
names(iris) <- gsub("\\.","",names(iris))
head(iris)
rPlot(SepalLength ~ SepalWidth | Species, color = "Species", type = "point", data = iris)

hairEye <- as.data.frame(HairEyeColor)
head(hairEye)
rPlot(Freq ~ Hair | Eye, color = "Eye", type = "bar", data = hairEye)

data(economics, package = "ggplot2")
head(economics)
tail(economics)
economics$date <- as.character(economics$date)
head(economics)

m1 <- mPlot(x="date", y=c("psavert", "uempmed"), type ="line", data = economics)
m1$set(pointSize=0, linewidth=1)
m1

map1 <- Leaflet$new()
map1$setView(c(51.505, -.09), zoom =13)
map1
