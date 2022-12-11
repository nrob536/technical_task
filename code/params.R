library(spocc) 
library(rgbif)
library(robis)
library(tidyverse)
library(proj4)
library(ggplot2)
library(spData)
library(sdmpredictors)
library(raster)
library(rasterVis)
library(biomod2)

polygon <-"POLYGON ((162.04834 -32.97180, 161.32324 -47.70976, 183.36182 -47.73932,181.95557 -32.84267, 162.04834 -32.97180))"

proj4 <- "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs "

col.names <- c("scientificName", "decimalLongitude", 'decimalLatitude', "source")

NZmap <- map_data("world")%>%
  filter (region == 'New Zealand' & subregion %in% c("North Island" , "South Island"))

  
xlim <- c(165,179)
ylim <- c(-47,-34)
e <- extent(165, 179, -47, -34)


myTheme=theme_bw()+
  theme(axis.title.x = element_blank(),
        axis.text.x  = element_text(family="Times",color="Black",vjust=0.5,size=10),
        axis.title.y = element_blank(),
        axis.text.y  = element_text(family="Times",colour="Black",
                                    size=10,
                                    vjust=0.5,
                                    hjust=0),
        panel.grid.major = element_blank(), 
        panel.grid.minor =element_blank(),
        plot.title=element_blank(),
        legend.position = c(0.8,0.2),
        legend.title = element_text(size=10,family="Times"),
        legend.text=element_text(size = 10, family = 'Times'),
        legend.key.size = unit(0.6, 'cm'),
        legend.key.width = unit(0.6, 'cm'),
        legend.background = element_blank())
