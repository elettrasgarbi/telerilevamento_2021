# R_code_land_cover.r
library(raster)
library(RStoolbox) #classification
# install.packages("gridExtra")
library(gridExtra)

# install.packages("ggplot2")
library(ggplot2)
defor1 <- brick("defor1.jpg")

setwd("C:/lab/") # Windows

#NIR 1, RED 2, GREEN 3
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=3, b=2, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra 
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
 
