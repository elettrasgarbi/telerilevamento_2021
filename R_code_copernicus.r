#R_code_copernicus.r
#visualizzazione copernicus e login
#dowload ALBEDO e Vegetation properties

#install.packages("ncdf4")
library(raster)
library(ncdf4)

# Windows
setwd("C:/lab/") 

albedo <- raster ("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
# adesso lo richiamo per visualizzare i dati
albedo 

#ora usiamo il plot e avendo un singolo strado decidiamo noi il colore 
cl <- colorRampPalette(c('blue','purple','yellow','orange'))(100) #
plot(albedo, col=cl)

#questo dato si può rivalutare con dei pixel un po' più grandi 
# ricampiono per aggregare più pixel = RICAMPIONAMENTO LINEARE 
# resampling
albedores <- aggregate(albedo, fact=100) #diminuisco l'informazione di 1000 volte 
plot(albedores, col=cl)

install.packages("knitr")
library(knitr)

install.packages("RStoolbox")
library(RStoolbox)


