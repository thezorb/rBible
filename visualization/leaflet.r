#leaflet
install.packages("leaflet")
library(leaflet)
leaflet() %>% addTiles() %>% addMarkers(lng=-74.0059, lat=40.7127)

places <- read.table('http://www.jaredlander.com/data/places.csv', sep=',', header=TRUE, 
                     stringsAsFactors=FALSE)
leaflet(places) %>% addTiles() %>% setView(0, 0, zoom=1) %>% addPopups(lng=~Longitude, lat=~Latitude, popup=~Place)

library(maps)
map('state', fill=TRUE)
mapStates <- map('state', fill=TRUE, plot=FALSE)
head(mapStates$names)
head(mapStates$x)
head(mapStates$y)

leaflet(data=mapStates) %>% addTiles
leaflet(data=mapStates) %>% addTiles() %>% addPolygons(fillColor=topo.colors(10, alpha=NULL))
leaflet(data=mapStates) %>% addTiles() %>% 
  addPolygons(fillColor=topo.colors(10, alpha=NULL), stroke=FALSE)
