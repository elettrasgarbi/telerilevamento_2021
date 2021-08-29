# R_code_no2.r

# 1. Set the working directory EN con --> setwd 

library(raster)
library(RStoolbox) #lo usiamo per la PCA quindi l'analisi multivariata 
setwd("C:/lab/EN")

#ora vohgliamo importare i dati su R
# la funzione brick importa si l'immagine ma tutte le bande
# noi siamo interessati a una sola banda quindi useremo la funzione raster
# la funzione raster ha bisogno del suo pacchetto, quindi lo andiamo a richiamare 

# 2. Importare la prima immagine (singola banda)
# se vuoi selezionare l abanda 1, ma la funzione raster permette di selezionare un'altra singola banda --> funzione terra 

EN01 <- raster("EN_0001.png")
plot(EN01)

# 3. plottiamo la prima immagine importata con la Color Ramp Palette che preferiamo 

cls <- colorRampPalette(c("red","pink","orange","yellow")) (200)
plot(EN01, col=cls)

# notiamo nella immagine plottata che in giallo evidenziano le zone di gennaio con no2 più alto 

# 4. importiamo l'ultima immagine (13) e la plottiamo con la stessa previous Color Ramp Palette

EN13 <- raster("EN_0013.png")

plot(EN13, col=cls)

# 5. andiamo ad associare a un oggetto la differenza delle due immagini e la plottiamo 
# con questa operazione vedimo la differenza tra la banda di Marzo e la banda di Gennaio
ENdif <- EN13 - EN01
plot (ENdif, col=cls)

# 6.ora faccimo il plot di tuttto, tutto insieme 
# la funzione da usare è par, e stabiliamo il numero di righe e il numero di colonne 

par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Different (January - March)")

# 7. importiamo tutto il set insieme 
#prima cosa dobbiamo fare una lista dei file 
# il pattern comune a tutti i file è EN
rlist <- list.files(pattern="EN")
rlist

# ora applicgiamo la funzione lapply a tutta la lista che ho creato e gli diamo il nome import
import <- lapply(rlist,raster)
import
#me li fa vedere tutti su R singolarmente 

# infine faccio lo stack dell'import e lo plottiamo 
EN <- stack(import) 
plot(EN, col=cls)

# 8. Replicare il plot dell'immagine 01 e 13 utilizzando il dollaro $ per legare 
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 9. Facciamo un'analisi multivariata con una PCA sulle 13 immagini 
#utilizziamo la funzione rasterPCA che è nel pacchetto RStoolbox --> quindi lo andiamo a richiamare 

ENpca <- rasterPCA(EN)
summary(ENpca$model)

dev.off()
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 10. calcolare la variabilità locale (deviazione standard locale) della prima immagine 
# la funzione da utilizzare è focal
# PC1sd <- focal(EN$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd) è sbagliata perche EN si trova nella funzione legato con map quindi dovremmo legare con il dollaro due volte 


PC1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cls)
























