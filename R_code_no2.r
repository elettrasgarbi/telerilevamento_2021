# R_code_no2.r

# 1. Set the working directory EN con --> setwd 

library(raster)
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
plot(EN13)

cls <- colorRampPalette(c("red","pink","orange","yellow")) (200)
plot(EN13, col=cls)

# 5. andiamo ad associare a un oggetto la differenza delle due immagini e la plottiamo 
