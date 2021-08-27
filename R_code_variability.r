#R_code_variability.r
library(raster)
library(RStoolbox)
#install.packages("RStoolbox")

setwd("C:/lab/") # Windows
#setwd("~/lab/") # Linux
# setwd("/Users/name/Desktop/lab/") # Mac
 
 sent <- brick("sentinel.png")
 #ora plottiamo la nostra immagine
 #NIR 1, RED 2, GREEM 3
 #r=1, g=2, b=3
 plotRGB(sent, stretch="lin") 
 #plotRGB(sent, r=1, g=2, b=3, stretch="lin")
