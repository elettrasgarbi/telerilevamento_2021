# Il mio primo codice in R per il telerilevamento!
# setwd("C:/lab/") # Windows

# install.packages("raster")
library(raster)

#questa funzione serve a importare un'immagine satellitare
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)
