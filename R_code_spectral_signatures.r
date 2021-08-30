# R_code_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)
setwd("C:/lab/")

#prima di tutto facciamo un brick per caricare tutte le bande dell'immagine che vogliamo analizzare 

defor2 <- brick("defor2.jpg")

#defor.2.1, defor.2.2, defor.2.3
#NIR, red, green
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# con lo stretch=hist i colori saranno più differenti perchè ci sara una curva molto più pendente 

plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#ora creiamo delle firme spettrali con la funzione 
# usando la libreria rgdal quindi andiamo a richiamarla 
# serve a cliccare su una mappa e avere qualsiasi di informazione 
# la funzione da utlizzare è click

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#risultati
#    x     y   cell defor2.1 defor2.2 defor2.3
# 1 444.5 296.5 130222      177      148      134
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 249.5 144.5 239011      192        7       13

#andiamo a fare un dataframe per poi crearci le nostre firme spettrali
#per la creazione del dataframe creiamo una storia delle nostre 3 bande 
# creiamo una tabella con 3 colonne 
# avremo 3 bande, poi avremo foresta o acqua e poi avremo questo dataframe 
# definiamo le colonne del dataset

band <- c(1,2,3)
forest <- c(177, 148,134)
water <- c(192,7,13)
 # abbiamo definito le colonne del nostro dataset e inserito i valori 
#ora vogliamo inserire tutto nella stessa colonna con la funzione Data Frame

spectrals <- data.frame(band, forest, water)

#ora richiamamo la libreria ggplot2 e creiamo la nostra libreria 
# funzione ggplot2 
#geom_line va a inserire le geometrie che ci interessano tipo le linee
#per richiamare l'asse x o y bisogna usare aes
# inseriamo la funzione labs dove scriviamo nei due assi x e y cosa trattano quindi x le band e la y la riflettanza 

ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") +
 labs(x="band",y="reflectance")

#---------------------------------------------------------------------------------------------------------------
#una cosa carina è fare questa analisi multitemporale, lo facciamo sulla stessa zona per semplicità
#le due immagini da utilizzare sono la defor1 e defor2 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

# adniamo a farsi dele spectral signatur della immagine defor1 

click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x     y   cell defor2.1 defor2.2 defor2.3
# 1 36.5 329.5 106153      198       11       18
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 59.5 340.5 98289      183      176      166
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 81.5 328.5 106915      169      134      130
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 86.5 373.5 74655      212       15       32
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 67.5 393.5 60296      203       31       31



# adniamo a farsi dele spectral signatur della immagine defor2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x     y   cell defor2.1 defor2.2 defor2.3
#1 100.5 309.5 120557      177      142      140
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 78.5 331.5 104761      207      209      188
#      x     y   cell defor2.1 defor2.2 defor2.3
#1 100.5 327.5 107651      177      161      146
#      x     y  cell defor2.1 defor2.2 defor2.3
#1 108.5 352.5 89734      200      172      158
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 87.5 360.5 83977      170      157      138

#ora creiamo il dataset con le colonne da definire 
band <- c(1,2,3) #le colonne sono sempre le stesse
time1 <- c(198, 11,18)
time1p2 <- c(183,176,166)   #time 1 e il secondo pixel e così cia 
time2 <- c(177,142,140)
time2p2 <- c(207,209,188)
#ora andiamo a fare il data.frame con la funzione spectrals
spectralst <- data.frame(band, time1, time2, time1p2, time2p2) #spectrals t perchè temporale

#ora andiamo a plottare il tutto 
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red", linetype="dotted") +     #possiamo cambiare lo spessore della linea con linetype e vengono delle linee tratteggiate
 geom_line(aes(y=time1p2), color="red", linetype="dotted") +
 geom_line(aes(y=time2), color="green", linetype="dotted") +
 geom_line(aes(y=time2p2), color="green", linetype="dotted") +
 labs(x="band",y="reflectance")

#andiamo sul sito nata Matters e andiamo a sceglierci un'immagine #https://earthobservatory.nasa.gov/blogs/earthmatters/2021/06/15/june-puzzler-7/
#image from Earth Observatorty

eo <- brick ("ISS006-E-43366_lrg.jpg")
plotRGB(eo, r=1, g=2, b=3, stretch="hist")
click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

# x      y   cell ISS006.E.43366_lrg.1 ISS006.E.43366_lrg.2
#1 463.5 1812.5 579576                   24                   13
#  ISS006.E.43366_lrg.3
#1                   27
#       x      y    cell ISS006.E.43366_lrg.1 ISS006.E.43366_lrg.2
#1 1243.5 1535.5 1420220                  106                   86
#  ISS006.E.43366_lrg.3
#1                   61
#       x      y    cell ISS006.E.43366_lrg.1 ISS006.E.43366_lrg.2
#1 1511.5 1190.5 2466528                  188                  183
#  ISS006.E.43366_lrg.3
#1                  180

band <- c(1,2,3)
stratum1 <- c(24,13,37)
stratum2 <- c(106,86,61)
stratum3 <- c(188,183,180)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3) #spectrals g perchè geology
#plottiamo lo spectral signature
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow", linetype="dotted") +     #possiamo cambiare lo spessore della linea con linetype e vengono delle linee tratteggiate
 geom_line(aes(y=stratum2), color="green", linetype="dotted") +
 geom_line(aes(y=stratum3), color="red", linetype="dotted") +
 labs(x="band",y="reflectance")


