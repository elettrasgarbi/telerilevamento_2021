# R_code_Exam.r
#  Il ritiro del ghiacciaio Columbia Glacier in Alaska dal 1986 al 2019
# immagini prese dal sito: https://earthobservatory.nasa.gov/world-of-change/ColumbiaGlacier

# caricamento delle library necessarie al funzionamento dei codici seguenti:
library(raster)  # permette l'utilizzo dei raster e funzioni annesse
library(rasterVis) # mi permette di visualizzare matrici e fornisce metodi di visualizzazione per i dati raster --> con questa libreria posso utilizzare la funzione levelplot
library(RStoolbox) # permette l'uso della Unsupervised Classification
library(ggplot2)  # permette l'uso delle funzioni ggplot
library(gridExtra)   # permette l'uso e creazione di griglie, tabelle e grafici
library(rgdal) # per le firme spettrali

# settaggio della working directory 
setwd("C:/lab/ES") # Windows

# Importo i file tutti insieme (invece che singolarmente) utilizzando la funzione stack
# Funzione list.files: crea lista di file per la funzione lapply 
clist <- list.files(pattern="columbia") # pattern = è la scritta in comune in ogni file, nel mio caso è columbia 
# per ottenre le informazioni sui file 
clist
# [1] "1 columbia_tm5_1986209_lrg.jpg"          
# [2] "2 columbia_tm5_1995202_lrg.jpg"          
# [3] "3 columbia_etm_2001258_lrg.jpg"          
# [4] "4 columbia_tm5_2005245_lrg.jpg"          
# [5] "5 columbia_oli_2013203_lrg.jpg"          
# [6] "6 columbiaglacier653_oli_2019172_lrg.jpg"

# Funzione lapply: applica alla lista dei file una funzione (raster) 
import <- lapply(clist,raster)
# per ottenre le informazioni sui file
import
# Funzione stack: raggruppa e rinomina, in un unico pacchetto, i file raster separati
ACi <- stack(import)
# Funzione per avere le info sul file
ACi
# Funzione plot: del singolo file
plot(ACi)
# Funzione plotRGB: crea plot con immagini sovrapposte
plotRGB(ACi, 3, 2, 1, stretch="hist")
# Funzione ggr: plotta file raster in differenti scale di grigio, migliorando la qualità dell'immagine e aggiungengo le coordinate spaziali sugli assi x e y
ggRGB(ACi, r=3, g=2, b=1, stretch="hist") # "hist": amplia i valori e aumenta i dettagli

# Funzione levelplot: disegna più grafici di colore falso con una singola legenda
levelplot(ACi)
# Cambio di colori a piacimento (colorRampPalette si può usare solo su immagine singole, non su RGB)
cls<-colorRampPalette(c("white","blue","yellow","green"))(100)
# Nuovo levelplot col cambio di colori, nome e titolo
levelplot(ACi,col.regions=cls, main="Variation ice cover in time", names.attr=c("1986","1995", "2001", "2005", "2013", "2019"))

#............................................................................................................................................................


# MULTIVARIATE ANALYSIS

# 1. Le coppie di funzioni producono una matrice di scatterplot.

# Traccia le correlazioni tra le 3 bande del mio stack.
# I valori di correlazione degli indici vanno da 0 a 1: 1= correlazione, 0 = nessuna correlazione
# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili)
pairs(ACi, main="Comparation with the function pairs")
# Result= 0.81
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri


# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file per avere dati e immagini a 3 bande
# Non utilizzo la funzione raster perchè successivamente farò l'analisi della PCA nella quale servono almeno 2 bande 
Columbia1986 <- brick("1 columbia_tm5_1986209_lrg.jpg")
Columbia1995 <- brick("2 columbia_tm5_1995202_lrg.jpg")
Columbia2001 <- brick("3 columbia_etm_2001258_lrg.jpg")
Columbia2005 <- brick("4 columbia_tm5_2005245_lrg.jpg")
Columbia2013 <- brick("5 columbia_oli_2013203_lrg.jpg")
Columbia2019 <- brick("6 columbiaglacier653_oli_2019172_lrg.jpg")



# 2. Analisi delle componenti principali

# PCA del ghiacciaio Columbia 1986
Columbia1986_pca <- rasterPCA(Columbia1986)
summary(Columbia1986_pca$model)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000
plotRGB(Columbia1986_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia1986_pca$model) # per vedere il grafico

# PCA del ghiacciaio Columbia 1995
Columbia1995_pca <- rasterPCA(Columbia1995)
summary(Columbia1995_pca$model)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3
# Standard deviation     100.4625005 64.8744795 30.03643478
# Proportion of Variance   0.6638371  0.2768225  0.05934038
# Cumulative Proportion    0.6638371  0.9406596  1.00000000
plotRGB(Columbia1995_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia1995_pca$model) # per vedere il grafico

# PCA del ghiacciaio Columbia 2001
Columbia2001_pca <- rasterPCA(Columbia2001)
summary(Columbia2001_pca$model)
# Importance of components:
#                           Comp.1     Comp.2      Comp.3
# Standard deviation     105.630334 61.4881533 26.10428909
# Proportion of Variance   0.714326  0.2420483  0.04362575
# Cumulative Proportion    0.714326  0.9563743  1.00000000
plotRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia2001_pca$model) # per vedere il grafico


# PCA del ghiacciaio Columbia 2005
Columbia2005_pca <- rasterPCA(Columbia2005)
summary(Columbia2005_pca$model)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3
# Standard deviation     100.5096631 65.2580821 31.65547453
# Proportion of Variance   0.6575716  0.2772018  0.06522665
# Cumulative Proportion    0.6575716  0.9347734  1.00000000
plotRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia2005_pca$model) # per vedere il grafico

# PCA del ghiacciaio Columbia 2013
Columbia2013_pca <- rasterPCA(Columbia2013)
summary(Columbia2013_pca$model)
# Importance of components:
#                           Comp.1     Comp.2      Comp.3
# Standard deviation     94.3610608 64.2087123 26.96819528
# Proportion of Variance  0.6473736  0.2997487  0.05287777
# Cumulative Proportion   0.6473736  0.9471222  1.00000000
plotRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia2013_pca$model) # per vedere il grafico

# PCA del ghiacciaio Columbia 2019
Columbia2019_pca <- rasterPCA(Columbia2019)
summary(Columbia2019_pca$model)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3
# Standard deviation     106.9109606 79.3440748 33.52695514
# Proportion of Variance   0.6063799  0.3339868  0.05963326
# Cumulative Proportion    0.6063799  0.9403667  1.00000000
plotRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia2019_pca$model) # per vedere il grafico

# confrontiamo le PCA ottenute dal 1986 al 2019
levelplot(ACi,col.regions=cls, main="Variation ice cover in time", names.attr=c("1986","1995", "2001", "2005", "2013", "2019"))

par(mfrow=c(2,3)) # 3 colonne e 2 righe
plotRGB(Columbia1986_pca$map,r=1,g=2,b=3, X$y, X$z, xlab="valori di Y",ylab="valori di X", stretch="Hist") #?????????????????????????????????????????????????????
plotRGB(Columbia1995_pca$map,r=1,g=2,b=3, X$y, X$z, xlab="valori di Y",ylab="valori di X", stretch="Hist")
plotRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# Multiframe con ggplot
Co1986 <- ggRGB(Columbia1986_pca$map,r=1,g=2,b=3, stretch="Hist")
Co1995 <- ggRGB(Columbia1995_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2001 <- ggRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2005 <- ggRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2013 <- ggRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2019 <- ggRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(Co1986, Co1995, Co2001, Co2005, Co2013, Co2019, nrow=2)

#......................................................................................................................................................

# Spectral Indices

# La funzione spectralIndices permette di calcolare tutti gli indici
# b1=NIR, b2=rosso, b3=verde
# Immagine del ghiacciaio Columbia in Alaska nel 1986 
spCo1986 <- spectralIndices(Columbia1986, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Cambio i colori con colorRampPalette
cl <- colorRampPalette(c('purple','yellow','light pink','orange'))(100)
# Nuovo plot col cambio di colori
plot(spCo1986, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 1995 
spCo1995 <- spectralIndices(Columbia1995, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spCo1995, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 2001 
spCo2001 <- spectralIndices(Columbia2001, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spCo2001, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 20005
spCo2005 <- spectralIndices(Columbia2005, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spCo2005, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 2013
spCo2013 <- spectralIndices(Columbia2013, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spCo2013, col=cl)

# Immagine del ghiacciaio Columbia in Alaska nel 2019 
spCo2019 <- spectralIndices(Columbia2019, green = 3, red = 2, nir = 1) #colori associati al N° della banda
# Nuovo plot col cambio di colori
plot(spCo2019, col=cl)

# 1. DVI - Difference Vegetation Index

# guardo come si chiamano le bande del NIR e del ROSSO. 
Columbia1986
#B1(NIR)= X1_columbia_tm5_1986209_lrg.1; B2(RED)=X1_columbia_tm5_1986209_lrg.2
Columbia1995
#B1(NIR)=X2_columbia_tm5_1995202_lrg.1; B2(RED)=X2_columbia_tm5_1995202_lrg.2
Columbia2001
#B1(NIR)=X3_columbia_etm_2001258_lrg.1; B2(RED)=X3_columbia_etm_2001258_lrg.2
Columbia2005
#B1(NIR)=X4_columbia_tm5_2005245_lrg.1; B2(RED)=X4_columbia_tm5_2005245_lrg.2
Columbia2013
#B1(NIR)=X5_columbia_oli_2013203_lrg.1; B2(RED)=X5_columbia_oli_2013203_lrg.2
Columbia2019
#B1(NIR)= X6_columbiaglacier653_oli_2019172_lrg.1; B2(RED)=X6_columbiaglacier653_oli_2019172_lrg.2



# Primo indice del ghiacciaio Columbia in Alaska nel 1986: NIR - RED
dvi1 <- Columbia1986$X1_columbia_tm5_1986209_lrg.1 - Columbia1986$X1_columbia_tm5_1986209_lrg.2
plot(dvi1)
cld <- colorRampPalette(c('yellow','purple','green','light blue'))(100)
plot(dvi1, col=cld, main="DVI of Columbia 1986")

# Primo indice del ghiacciaio Columbia in Alaska nel 1995: NIR - RED
dvi2 <- Columbia1995$X2_columbia_tm5_1995202_lrg.1 - Columbia1995$X2_columbia_tm5_1995202_lrg.2
plot(dvi2)
plot(dvi2, col=cld, main="DVI of Columbia 1995")

# Primo indice del ghiacciaio Columbia in Alaska nel 2001: NIR - RED
dvi3 <- Columbia2001$X3_columbia_etm_2001258_lrg.1 - Columbia2001$X3_columbia_etm_2001258_lrg.2
plot(dvi3)
plot(dvi3, col=cld, main="DVI of Columbia 2001")

# Primo indice del ghiacciaio Columbia in Alaska nel 2005: NIR - RED
dvi4 <- Columbia2005$X4_columbia_tm5_2005245_lrg.1 - Columbia2005$X4_columbia_tm5_2005245_lrg.2
plot(dvi4)
plot(dvi4, col=cld, main="DVI of Columbia 2005")

# Primo indice del ghiacciaio Columbia in Alaska nel 2013: NIR - RED
dvi5 <- Columbia2013$X5_columbia_oli_2013203_lrg.1 - Columbia2013$X5_columbia_oli_2013203_lrg.2
plot(dvi5)
plot(dvi5, col=cld, main="DVI of Columbia 2013")

# Primo indice del ghiacciaio Columbia in Alaska nel 2019: NIR - RED
dvi6 <- Columbia2019$X6_columbiaglacier653_oli_2019172_lrg.1 - Columbia2019$X6_columbiaglacier653_oli_2019172_lrg.2
plot(dvi6)
plot(dvi6, col=cld, main="DVI of Columbia 2019")

# Confronto il tutto per far emergere le differenze 
par(mfrow=c(2,3))
plot(dvi1, col=cld, main="DVI of Columbia 1986")
plot(dvi2, col=cld, main="DVI of Columbia 1995")
plot(dvi3, col=cld, main="DVI of Columbia 2001")
plot(dvi4, col=cld, main="DVI of Columbia 2005")
plot(dvi5, col=cld, main="DVI of Columbia 2013")
plot(dvi6, col=cld, main="DVI of Columbia 2019")


difdvi <- (dvi1 - dvi2) - (dvi3 - dvi4) - (dvi5 - dvi6)
cldd <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cldd)


# 2. NDVI - Normalized Difference Vegetation Index

# NDVI= (NIR-RED) / (NIR+RED)
# NDVI del ghiacciaio Columbia in Alaska nel 1986
ndvi1 <- (dvi1) / (Columbia1986$X1_columbia_tm5_1986209_lrg.1 + Columbia1986$X1_columbia_tm5_1986209_lrg.2)
plot(ndvi1, col=cld, main="NDVI of Columbia 1986")

# NDVI del ghiacciaio Columbia in Alaska nel 1995
ndvi2 <- (dvi2) / (Columbia1995$X2_columbia_tm5_1995202_lrg.1 + Columbia1995$X2_columbia_tm5_1995202_lrg.2)
plot(ndvi2, col=cld, main="NDVI of Columbia 1995")

# NDVI del ghiacciaio Columbia in Alaska nel 2001
ndvi3 <- (dvi3) / (Columbia2001$X3_columbia_etm_2001258_lrg.1 + Columbia2001$X3_columbia_etm_2001258_lrg.2)
plot(ndvi3, col=cld, main="NDVI of Columbia 2001")

# NDVI del ghiacciaio Columbia in Alaska nel 2005
ndvi4 <- (dvi4) / (Columbia2005$X4_columbia_tm5_2005245_lrg.1 + Columbia2005$X4_columbia_tm5_2005245_lrg.2)
plot(ndvi4, col=cld, main="NDVI of Columbia 2005")

# NDVI del ghiacciaio Columbia in Alaska nel 2013
ndvi5 <- (dvi5) / (Columbia2013$X5_columbia_oli_2013203_lrg.1 + Columbia2013$X5_columbia_oli_2013203_lrg.2)
plot(ndvi5, col=cld, main="NDVI of Columbia 2013")

# NDVI del ghiacciaio Columbia in Alaska nel 2019
ndvi6 <- (dvi6) / (Columbia2019$X6_columbiaglacier653_oli_2019172_lrg.1 + Columbia2019$X6_columbiaglacier653_oli_2019172_lrg.2)
plot(ndvi6, col=cld, main="NDVI of Columbia 2019")

# Confronto il tutto per far emergere le differenze
par(mfrow=c(2,3))
plot(ndvi1, col=cld, main="NDVI of Columbia 1986")
plot(ndvi2, col=cld, main="NDVI of Columbia 1995")
plot(ndvi3, col=cld, main="NDVI of Columbia 2001")
plot(ndvi4, col=cld, main="NDVI of Columbia 2005")
plot(ndvi5, col=cld, main="NDVI of Columbia 2013")
plot(ndvi6, col=cld, main="NDVI of Columbia 2019")

# Differenza del NDVI
difndvi <- (ndvi1 - ndvi2) - (ndvi3 - ndvi4) - (ndvi5 - ndvi5)
plot(difndvi, col=cldd)

#.....................................................................................................................................

# FIRME SPETTRALI

# Creo una firma spettrale dell'immagine Columbia 1986 con la funzione "click"
plotRGB(Columbia1986, r=1, g=2, b=3, stretch="lin")
click(Columbia1986, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# In a pixel of vegetation -> B1= very high value, B2=low value, B3= average value
# In a pixel of water -> B1= low value, B2= high value, B3= very high value
# Results:



