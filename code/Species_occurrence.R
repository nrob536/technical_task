library(spocc) 
library(rgbif)
library(robis)
library(dplyr)
library(proj4)

{gbif <- occ (query = 'Undaria pinnatifida',
              from = 'gbif',
              gbifopts = list(publishingCountry="NZ"))
Undaria.gbif <- occ2df(gbif)}

Undaria.obis <- occurrence("Undaria pinnatifida", 
                   geometry = polygon)

Undaria.mbph <- read.csv ("../data/Undaria_Porthole.csv", header = T)

# Combining the three data sources we have a total of 8,972 presence records. 
# This is a great starting point. However, data needs to be standardize as naming conventions vary greatly. 
# To build Species Distribution Models, the presence dataset needs only three parameters: A scientific name, latitude and longitude coordinates.
# The coordinates from the Marine Biosecurity Porthole are given in Easting and Northing (UTM), so we first need to convert these to lat/long


{proj4 <- "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs "

x_y <- Undaria.mbph[,26:27]
lon_lat <- as.data.frame(project(x_y, proj4, inverse=T)) %>%
  rename(c(longitude = x, latitude = y))
}


{data.mbph <- cbind(Undaria.mbph, lon_lat)%>%
  select (taxon_name, longitude, latitude)%>%
  mutate (source = "MBPH")%>%
  rename (scientificName = taxon_name)

data.obis <- Undaria.obis %>%
  select (scientificName, decimalLongitude, decimalLatitude)%>%
  mutate (source = "OBIS")%>%
  rename (c(longitude = decimalLongitude, latitude = decimalLatitude))

data.gbif <- Undaria.gbif %>%
  mutate (scientificName = "Undaria pinnatifida", source = "GBIF")%>%
  select(scientificName, longitude, latitude, source)
}

UndariaNZ <- rbind(data.mbph, data.obis, data.gbif)  


var.names <- c("scientificName", "decimalLongitude","decimalLatitude", "source") 
