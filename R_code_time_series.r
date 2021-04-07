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

#sovrapposizione delle 3 immagini 2000,2005 e 2010
plotRGB(TGr, 1, 2, 3, stretch="Lin")

lst_2015 <- raster ("lst_2015.tif")
plot(lst_2015)

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#invece che importare i singoli dati, si usa la funzione stack e usarli tutti insieme 
rlist <- list.files(pattern="tif")
rlist
import <- lapply(rlist,raster)
TGr <- stack(import)
plot(TGr)

#plottiamo usando direttamente i dati uniti con uno stack
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

#installiano un'altra library
library(rasterVis)
