library(networkD3)
# force-directed graphs with D3 
#
# create fake data
#
src <- c("A","A","A","A", "B","B","C","C","D")
target <- c("B","C","D","J","E","F","G","H","I")
networkData <- data.frame(src, target)
#
# plot
simpleNetwork(networkData)
#
data("MisLinks")
data("MisNodes")
#
forceNetwork(Links=MisLinks, Nodes=MisNodes, 
             Source="source", Target="target",
             Value="value", NodeID="name",
             Group="group", opacity=0.8)
#
# Sankey diagrams
#
# load energy projection data
URL <- paste0("https://cdn.rawgit.com/christophergandrud/networkD3/",
              "master/JSONdata/energy.json")
Energy <- jsonlite::fromJSON(URL)
#
# plot
sankeyNetwork(Links=Energy$links, Nodes=Energy$nodes, 
              Source="source", Target="target",
              Value="value", NodeID="name",
              units="TWh", fontSize=12, nodeWidth=30)
#
# Radial or 'tree' graphs
#
URL <- paste0("https://cdn.rawgit.com/christophergandrud/networkD3/",
              "master/JSONdata/flare.json")
# convert to list format
Flare <- jsonlite::fromJSON(URL, simplifyDataFrame=FALSE)
#
# use subset of data for more readable diagram
Flare$children = Flare$children[1:3]

radialNetwork(List=Flare, fontSize=10, opacity=0.9)
#
diagonalNetwork(List=Flare, fontSize=10, opacity=0.9)
#
# fun with geography :)
install.packages("ggmap", type="source")
library(ggmap)

qmap(location="hood college", zoom=16, source="google")
qmap(location="harrisburg university PA", zoom=14, source="google")
qmap(location="warwick, RI", zoom=14, source="google")

#
# 
mydata = read.csv("~/Downloads/vehicle-accidents.csv")

mydata$State <- as.character(mydata$State)
mydata$MV.Number = as.numeric(mydata$MV.Number)
mydata = mydata[mydata$State != "Alaska",]
mydata = mydata[mydata$State != "Hawaii",]
mydata = mydata[mydata$State != "USA",]
for (i in 1:nrow(mydata)) {
  latlon = geocode(mydata[i,1])
  mydata$lon[i] = as.numeric(latlon[1])
  mydata$lat[i] = as.numeric(latlon[2])
}
mv_num_collisions = data.frame(mydata$MV.Number, mydata$lon, mydata$lat)
colnames(mv_num_collisions) = c('collisions','lon','lat')
circle_scale_amt = 0.1
usa_center = as.numeric(geocode("United States"))
USAMap = ggmap(get_googlemap(center=usa_center, scale=2, zoom=4),extent="normal")
USAMap + geom_point(aes(x=lon,y=lat), data=mv_num_collisions, col="orange",
                    alpha=0.4, size=mv_num_collisions$collisions*circle_scale_amt) +
  scale_size_continuous(range=range(mv_num_collisions$collisions))

# heat maps
#
library(ggplot2)
library(ggmap)

tartu_housing <- read.csv("~/Desktop/R-Work/data/tartu.csv", sep=";")
tartu_map <- get_map(location="tartu", maptype="satellite", zoom=12)
ggmap(tartu_map, extent='device') + 
  geom_point(aes(x=lon,y=lat), colour="red", alpha=0.1, size=2, data=tartu_housing)

tartu_map_g_str <- get_map(location="tartu", zoom=13)
ggmap(tartu_map_g_str, extent='device') +
  geom_density2d(data=tartu_housing, aes(x=lon, y=lat),size=0.3) +
  stat_density2d(data=tartu_housing, aes(x=lon, y=lat, fill= ..level.., alpha= ..level..),
                 size=0.01, bins=16, geom="polygon") +
  scale_fill_gradient(low="green",high="red") + 
  scale_alpha(range=c(0,0.3), guide=FALSE)

# 
#
jg_housing <- read.csv("~/Desktop/R-Work/data/jg_housing.csv", sep=";")
jogeva_map_g_str <- c(lon=26.4, lat=58.7)
jogeva_map_g_str_m <- get_map(jogeva_map_g_str, zoom=9)
ggmap(jogeva_map_g_str_m, extent='device') +
  geom_density2d(data=jg_housing, aes(x=lon, y=lat), size=0.3) +
  stat_density2d(data=jg_housing, aes(x=lon, y=lat, fill = ..level.., alpha = ..level..),
                 size=0.01, bins=16, geom = 'polygon') +
  scale_fill_gradient(low="green", high="red", guide=FALSE) +
  scale_alpha(range = c(0, 0.30), guide=FALSE)

# housing density
#
housing_sett <- read.csv("~/Desktop/R-Work/data/housing_sett.csv", sep=";")
jmap <- get_map(location=jogeva_map_g_str, maptype="hybrid", zoom=9)
ggmap(jmap, extent='device') +
  geom_density2d(data=housing_sett, aes(x=lon,y=lat), size=0.3) +
  stat_density2d(data=housing_sett, aes(x=lon,y=lat, fill=..level.., alpha=..level..),
                 size=0.01, bins=16, geom = 'polygon') +
  scale_fill_gradient(low="green", high="red", guide=FALSE) +
  scale_alpha(range=c(0, 0.30), guide=FALSE)


 
    