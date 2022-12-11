data <- 
  do.call (rbind,
    lapply(list.files(path="./"), read.csv))

library(proj4)
library(dplyr)

proj4 <- "+proj=tmerc +lat_0=0 +lon_0=173 +k=0.9996 +x_0=1600000 +y_0=10000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs "

x_y <- data[,25:26]
lon_lat <- as.data.frame(project(x_y, proj4, inverse=T)) %>%
  rename(c(longitude = x, latitude = y))

write.csv(data.mbph, "C:/Users/robin/OneDrive/technical_task/data/Undaria_mbph.csv", row.names = F)
data.mbph <- cbind(data, lon_lat)

