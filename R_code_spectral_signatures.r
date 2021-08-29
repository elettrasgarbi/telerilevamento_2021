# R_code_spectral_signatures.r

library(raster)
setwd("C:/lab/")

#prima di tutto facciamo un brick per caricare tutte le bande dell'immagine che vogliamo analizzare 

defor2 <- brick("defor2.jpg")
