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


