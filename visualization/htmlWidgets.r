#HTML widgets
data(baseball, package ='plyr')
baseball <- baseball[baseball$year >= 2000,]
library(DT)
datatable(baseball)
datatable(baseball, rownames=FALSE)
datatable(baseball, rownames=FALSE, extensions = 'Scroller')
datatable(baseball, rownames=FALSE, extensions = 'Scroller', filter = 'top', style = 'bootstrap',
          options=list(dom='frtis',
                       scrolly=400,
                       scrollCollapes=TRUE))
