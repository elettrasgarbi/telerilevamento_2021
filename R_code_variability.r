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
#noi la vogliamo inserire nello schema rgb
 plotRGB(sent, stretch="lin") 
 #plotRGB(sent, r=1, g=2, b=3, stretch="lin")
# se vogliamo invertire faremo
plotRGB (sent, r=2, g=1, b=3, stretch="lin")
# le macchie nere sono acqua e ombra 
#per fare il calcolo della deviazione standard abbiamo a disposizione solamente una banda 
#> la variabilità > sarà la deviazione stadard
#associamo la nostra banda a un oggetto = nir
nir <- sent$sentinel.1
red <- sent$sentinel.2

#calcoliamo ndvi
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
#ndvi va da -1 a 1 e dove vediamo il bianco nell'immagine significa che non c'è vegetazione 
#possiamo cambiare la color ramp
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#calcoliamo la deviazione standard cioè la variabilità di questa immagine
#utilizzeremo la funzione FOCAL
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

#cambiamo la color and palette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)

# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

#13x13 pixel
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

#ideale avere una finestra di 5x5 pizel, ideale per studiare la deviazione standard per quella area
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

#c'è un'altra tecnica per compattare i dati = funzione rastePCA
sentpca <- rasterPCA (sent)
plot(sentpca$map)
#analisi multivariata della nostra immagine 
#facciamo una summer iniziale per vedere quanta variabilità inziale spiegano i modelli

summary(sentpca$model)
# il primo PC contiene il 67,36804% delle informazioni originali

pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(pc1sd5, col=clsd)

#per copiare codici senza fare copia e incolla, utilizzare la funzione source salvando il file sulla nostra cartella e importandola su R sempre con le virgolette
#preso un pezzo di codice salvato direttamente da virtuale su cartella lab e caricato su R
source("source_test_lezione.r")
#vediamo una deviazione standard 7x7 pixel
#la libreria viridis serve per colorare i plot di ggplot e assicuriamoci di aver installato viridis
install.packages("viridis")
library(viridis)

#plottiamo con source il codice salvato da virtuale su lab 
source("source_ggplot.r")

#la funzione ggplot ci crea una finestra vuota
# per aggiungere dei blocchi utilizzare il +
# funzione geom_raste della nostra mappa 
#ora definizamo le estetiche = cioè cosa plottiamo, le x e le y

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

#metodo migliore a livello geografico per individuare qualsiasi discontinuità




