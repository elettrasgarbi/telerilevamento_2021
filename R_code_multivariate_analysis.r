# R_code_multivariate_analysis.r
# inziamo a fare analisi multivariate 
library(raster)
library(RStoolbox)

setwd("C:/lab/") # Windows

# andiamo a caricare tutta l'immagine
# brick con tanti set
# set solo un set

p224r63_2011 <- brick ("p224r63_2011_masked.grd")
plot(p224r63_2011)

# per avere info sull'immagine, basta mandare su R il nome dell'immagine 
p224r63_2011

# class      : RasterBrick 
# dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
# resolution : 30, 30  (x, y)
# extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
# crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
# source     : C:/lab/p224r63_2011_masked.grd 
# names      :       B1_sre,       B2_sre,       B3_sre,       B4_sre,       B5_sre,        B6_bt,       B7_sre 
# min values : 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.196277e-02, 4.116526e-03, 2.951000e+02, 0.000000e+00 
# max values :    0.1249041,    0.2563655,    0.2591587,    0.5592193,    0.4894984,  305.2000000,    0.3692634 

# con il $ uniamo le due immagini banda 1 e banda 2 

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="green", pch=19, cex=2)

# se voglio invertire le due bande
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="green", pch=19, cex=2)

# nuova funzione pairs = mette in correlazione tutte le variabili 
pairs(p224r63_2011)

# questa funzione mette in correlazione a 2 a 2 tutte le variabili di un certo dataset che sono le bande 
# correlazione tra banda 1 e 3, tra 1 e 3... e così via 
# sulla parte alta della nostra matrice emerge un INDICE = INDICE DI CORRELAZIONE, varia tra -1 e 1 
# se si è correlati in modo perfetto, l'indice sarà 1
# se si è negativamente correlati, l'indice va a -1 
# banda 1 e banda 2 hanno come indice 0.93, quinid sono correlatissime 
# sistema di 7 bande 

# funzione aggregate cells = riducimo la dimensione dell'immagine aggregando i pixer 
# fact = fattore 10 lineare aumentando i nostri pixer
# aggregate cells: resampling (ricambionamento) 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res
# ora abbiamo allunganto la lunghezza del pixer da 30 a 300

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# funzione per fare la PCA = rasterPCA, prende il nostre pacchetto di dati e li va a compattare in un numero minore di bande 
# il pacchetto di riferimento è Rstoolboc che abbiamo già scaricato 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

 
# come si fa a legare due oggetti dentro r = $
# summery = funzione base che ci da un sommario del nostro modello 
summary(p224r63_2011res_pca$model)
# lanciato dentro r il comando dice: 0.9983 = spiega il 99% della variabilità 

plot(p224r63_2011res_pca$map)
# prima componente con tanta informazione e l'ultima con poca informazione 
p224r63_2011res_pca
# ora plottiamo in RGB tutta l'immagine con le 3 complonenti principali
dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")











