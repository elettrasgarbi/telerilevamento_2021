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

#una funzione all'interno del pacchetto rasterVis che fa una media dei valori
levelplot(copNDVI)
 

#ritento di riscrivere il codice 
# R_code_vegetation-indices
# carichiamo le librerie
library(raster)
library(RStoolbox) # for vegetation indices calculation
library(rasterdiv) # for the worldwide NDVI
library(rasterVis)
# settiamo la working directory
setwd("C:/lab/")
# carichiamo le immagini utilizzando la funzione brick
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1= NIR, b2= red, b3= green

# visualizziamo le due immagini insieme creando un par
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# different vegetation index
defor1
# in questo modo otteniamo le informazioni relative all'immagine
# calcoliamo l'indice di vegetazione della prima immagine
dvi1 <- defor1$defor1.1 - defor1$defor1.2
# si ottiene una mappa formata da pixel che sono dati dalla differezza tra l'infrarosso e il rosso 
# visualizziamo la mappa con la funzione plot
plot(dvi1)
# questa mappa mostra lo stato di salute della vegetazione
# ora modifchiamo la colorRampPalette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
# visualizziamo l'immagine con i nuovi colori assegnati
plot(dvi1, col=cl)

# facciamo la stessa cosa per la seconda immagine
defor2
# in questo modo visualizziamo il nome delle bande associate a questa immagine
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
# visualizziamo l'immagine con i nuovi colori assegnati
plot(dvi2, col=cl)
# la parte gialla della mappa indica le zone in cui non è più presente vegetazione

# visualizziamo le due immagini assieme con la funzione par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# facciamo la differenza tra le due mappe
difdvi <- dvi1 - dvi2
# utilizziamo una colorRampPalette diversa
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
# ottengo una mappa in cui dove la differenza è maggiore il colore sarà rosso per cui indica dove c'è stata unaperdita maggiore della vegetazione nel tempo

# ndvi1
# (NIR-RED) / (NIR+ RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# for vegetation indices calculation
# spectral indices
# con questa funzioni si calcolano tutti gli indice e vengono inseriti tutti in un'unica immagine
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)
# facciamo lo stesso per la seconda immagine
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# for the worldwide NDVI
plot(copNDVI)
# otteniamo una mappa del NDVI a livello globale
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
# questa funzione permette di modificare dei valori, in questo caso eliminiamo la parte dell'immagine relativa all'acqua
plot(copNDVI)

#rasterVis package needed
levelplot(copNDVI)




