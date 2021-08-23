# R_code_vegetation_indices.r
# scarichiamo da virtuale le due immagine sullla cartella lab 
library(raster) # require(raster) che fa la stessa cosa di library
library(RStoolbox) # for vegetation indices calculation
# install.packages("rasterdiv") 
library(rasterdiv) # fore the worldwide NDVI

#install.packages("rasterVis")
library(rasterVis)
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

# ora andiamo a vederli entrambi plottandoli insieme usando la funzione PAR
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# ora facciamo la differenza delle due mappe 
difdvi <- dvi1 - dvi2 
# mi dice che l'estensione delle due immagini non è la stessa, molto probabilmente una delle due immagini ha qualche pixer in più 
# ma non è un problema perchè calcolerà il dato nella loro intersezione 

# dev.off()
# andiamo ad evidenziare la differenza con colour and palette e abbiamo la mappa su una sola banda 
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
# dove la differenza è più forte avremo un colore rosso, viceversa un colore blu/bianco 
# un immagine a 16 b ha dei valori che vanno da 0 a 2^16= 65536
#quindi nel primo tempo ho 255 nella seconda 65535 e non ha senso confrontarle allora usiamo un altro indice
# NDVI = normalizzazione della somma, con questo comando possiamo comparare immagini che hanno valori diversi di entrata 
# il ranhe del NDVI ha sempre lo stesso range cioè minumo di -1 e massimo di +1
#si calcola 
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot (ndvi1, col=cl)

# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot (ndvi1, col=cl)

# nel pacchetto RStoolbox si trova la funzione spectralIndices che possiamo utilizzare per fare il calcolo 

# andiamo a calcoare i valori della seconda immagine e per vedere lancio il comando defor2 

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot (ndvi2, col=cl)

# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# stessa cosa anche per la seconda 
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# fare la differenza tra i due ndvi
difndvi <- ndvi1 - ndvi2

 

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

#worldwide NDVI
plot(copNDVI)
# Pixel with values 253, 254  and 255 (water) will be set as Na's
# eliminiamo l'acqua dall'immagine 
# con i : diamo il range
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

levelplot(copNDVI)
 






