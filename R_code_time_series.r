# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#install.packages("raster")
library(raster)
setwd("C:/lab/greenland") # Windows

# importiamo i dati tif uno a uno contenuti nella cartella greenland
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster ("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster ("lst_2010.tif")
plot(lst_2010)

lst_2015 <- raster ("lst_2015.tif")
plot(lst_2015)

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
