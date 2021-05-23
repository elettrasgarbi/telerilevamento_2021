# R_code_vegetation_indices.r
# scarichiamo da virtuale le due immagine sullla cartella lab 
library(raster) # require(raster) che fa la stessa cosa di library

setwd("C:/lab/") # Windows

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green
# ora le plottimao 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#andiamo a fare il primo indice
# per vedere i nomi delle varie mande, lanciare su r, defor 1 e poi defor 2 
defor1
# names      : defor1.1, defor1.2, defor1.3 
# per ogni pixer fare la differenza dell'infrarosso e rosse
#different vegetable index 
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#dev.off()
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl, main="DVI at time 1")

 #ora facciamo la stessa cosa per il defor2
defor2
#names      : defor2.1, defor2.2, defor2.3 
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")
