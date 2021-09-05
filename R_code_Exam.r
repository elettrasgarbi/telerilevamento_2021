####################################
#### ghiacciaio Columbia Alaska ####
####################################

#######################################################
### Intro ###
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
# class      : RasterStack 
# dimensions : 1080, 1920, 2073600, 6  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 1920, 0, 1080  (xmin, xmax, ymin, ymax)
# crs        : NA 
# names      : X1_columb//986209_lrg, X2_columb//995202_lrg, X3_columb//001258_lrg, X4_columb//005245_lrg, X5_columb//013203_lrg, X6_columb//019172_lrg 
# min values :                     0,                     0,                     0,                     0,                     0,                     0 
# max values :                   255,                   255,                   255,                   255,                   255,                   255

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

# ora applichiamo l'algebra applicata alle matrici 
#utilizzo raster perchè non mi interessa ad avere le 3 bande divise ma una immagine con un'unica banda 
Columbiaraster1986 <- raster("1 columbia_tm5_1986209_lrg.jpg")
Columbiaraster2019 <- raster("6 columbiaglacier653_oli_2019172_lrg.jpg")
#vogliamo fare la sottrazione tra il primo e l'ultimo dato 
# $ il dollaro mi lega il file originale al file interno 
Columbiaice <- Columbiaraster2019 - Columbiaraster1986
# creo una nuoca colour and palette 
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(Columbiaice, col=clb) # zone rosse dove c'è stato uno scioglimento dei ghiacci 
# usiamo level per avere una gamma di colori più dettagliata 
levelplot(Columbiaice, col.regions=clb, main="Scioglimento del ghiaccio dal 1986 al 2019")

# 2. Analisi delle componenti principali

# PCA del ghiacciaio Columbia 1986
Columbia1986_pca <- rasterPCA(Columbia1986)
summary(Columbia1986_pca$model)
# Importance of components:
#                             Comp.1     Comp.2      Comp.3
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
plotRGB(Columbia1986_pca$map,r=1,g=2,b=3, stretch="Hist", main="DVI of Columbia 1986") 
plotRGB(Columbia1995_pca$map,r=1,g=2,b=3, stretch="Hist", main="DVI of Columbia 1986") 
plotRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# Multiframe con ggplot
Co1986 <- ggRGB(Columbia1986_pca$map,r=1,g=2,b=3, stretch="Hist")       #????????????????????????????????????????????????????? come mettere il titolo 
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
# x     y    cell X1_columbia_tm5_1986209_lrg.1 X1_columbia_tm5_1986209_lrg.2 X1_columbia_tm5_1986209_lrg.3
#1 969.5 129.5 1824970                             5                           142                           186
#     x     y    cell X1_columbia_tm5_1986209_lrg.1 X1_columbia_tm5_1986209_lrg.2 X1_columbia_tm5_1986209_lrg.3
# 1 950.5 405.5 1295031                             8                           104                           152
#      x     y   cell X1_columbia_tm5_1986209_lrg.1 X1_columbia_tm5_1986209_lrg.2 X1_columbia_tm5_1986209_lrg.3
# 1 905.5 599.5 922506                            20                           181                           209


# Creo una firma spettrale dell'immagine Columbia 2019 con la funzione "click"
plotRGB(Columbia2019, r=1, g=2, b=3, stretch="lin")
# Bisogna avere la mappa fatta con plotRGB aperta sotto
# Utilizzo la funzione click per cliccare sull'immagine plotRGB e le firme spettrali 
click(Columbia2019, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# In a pixel of vegetation -> B1= very high value, B2=low value, B3= average value
# In a pixel of water -> B1= low value, B2= high value, B3= very high value
# Results:
# x     y    cell X6_columbiaglacier653_oli_2019172_lrg.1 X6_columbiaglacier653_oli_2019172_lrg.2 X6_columbiaglacier653_oli_2019172_lrg.3
# 1 978.5 175.5 1736659                                      12                                      29                                      55
# 2 953.5 368.5 1366074                                       9                                      32                                      73
# 3 908.5 592.5  935949                                       8                                      28                                      81

# Creo ora un set di dati con i nostri risultati, definendo le colonne del dataset
band <- c(1,2,3)
Columbia1986p1 <- c(5, 142, 186)
Columbia1986p2 <- c(8, 104, 152)
Columbia1986p3 <- c(20, 181, 209)
Columbia2019p1 <- c(12, 29, 55)
Columbia2019p2 <- c(9, 32, 73)
Columbia2019p3 <- c(8, 28, 81)

# Funzione data.frame: crea un dataframe (tabella)
spectralCo <- data.frame(band,Columbia1986p1,Columbia1986p2,Columbia1986p3,Columbia2019p1,Columbia2019p2,Columbia2019p3)

# richiamo spectralst per avere le info sul file
spectralCo
# band Columbia1986p1 Columbia1986p2 Columbia1986p3 Columbia2019p1 Columbia2019p2 Columbia2019p3
# 1    1              5              8             20             12              9              8
# 2    2            142            104            181             29             32             28
# 3    3            186            152            209             55             73             81


# Plot delle firme spettrali
# Utilizzo la funzione ggplot per determinare l'estetica del grafico
# Rosso per i risultati del 2019, blu per i risultati del 2021
# Funzione geom_line: connette le osservazioni a seconda del dato che è sulla X/Y
# Funzione labs: modifica le etichette degli assi, le legende e il plottaggio
ggplot(spectralCo, aes(x=band)) +
geom_line(aes(y = Columbia1986p1), color="blue") +
geom_line(aes(y = Columbia1986p2), color="blue") +
geom_line(aes(y = Columbia1986p3), color="blue") +
geom_line(aes(y = Columbia2019p1), color="red") +
geom_line(aes(y = Columbia2019p2), color="red") +
geom_line(aes(y = Columbia2019p3), color="red") +
labs(x="band", y="reflectance")

# Traccio questo set di dati con altri colori
# Il colore chiaro rappresenta i risultati del 1986, il colore scuro rappresenta i risultati del 2019
ggplot(spectralCo, aes(x=band)) +
geom_line(aes(y = Columbia1986p1), color="light blue") +
geom_line(aes(y = Columbia1986p2), color="pink") +
geom_line(aes(y = Columbia1986p3), color="yellow") +
geom_line(aes(y = Columbia2019p1), color="orange") +
geom_line(aes(y = Columbia2019p2), color="blue") +
geom_line(aes(y = Columbia2019p3), color="purple") +
labs(x="band", y="reflectance")
#questo procedimento normalmente si fa con moltissimi pixel. si usa una funzione per la generazione dei punti random e poi un'altra per estrarre da tutti i valori delle bande

#------------------------------------------------------------------------------------------------------------------------------------------------

#effettuiamo una categorizzazione in 3 classi di colore per distinguere le zone con ghiaccio, con acqua e "altro"
CoAlask1 <- unsuperClass(Columbia1986, nClasses=4)  
CoAlask2 <- unsuperClass(Columbia1995, nClasses=4)  
CoAlask3 <- unsuperClass(Columbia2001, nClasses=4)  
CoAlask4 <- unsuperClass(Columbia2005, nClasses=4)  
CoAlask5 <- unsuperClass(Columbia2013, nClasses=4)  
CoAlask6 <- unsuperClass(Columbia2019, nClasses=4) 

plot(CoAlask1$map)
freq(CoAlask1$map)  # freq è la funzione che mi va a calcolare la frequenza 
#      value  count
# [1,]     1 561438 --> acqua 
# [2,]     2 644303 --> neve 
# [3,]     3 577552 --> vegetazione
# [4,]     4 290307 --> ghiaccio


plot(CoAlask2$map)
freq(CoAlask2$map)  
#      value  count
# [1,]     1 579046 --> acqua 
# [2,]     2 644664 --> vegetazione
# [3,]     3 491625 --> neve 
# [4,]     4 358265 --> ghiaccio



plot(CoAlask3$map)
freq(CoAlask3$map) 
#      value  count
# [1,]     1 710476 --> acqua 
# [2,]     2 554057 --> vegetazione
# [3,]     3 417466 --> ghiaccio
# [4,]     4 391601 --> neve 
 


plot(CoAlask4$map)
freq(CoAlask4$map)  
#      value  count
# [1,]     1 449513 --> ghiaccio
# [2,]     2 207420 --> neve 
# [3,]     3 664488 --> vegetazione
# [4,]     4 752179 --> acqua 

plot(CoAlask5$map)
freq(CoAlask5$map)  
#      value  count
# [1,]     1 290029 --> ghiaccio
# [2,]     2 608635 --> acqua
# [3,]     3 393560 --> neve 
# [4,]     4 781376 --> vegetazione

plot(CoAlask6$map)
freq(CoAlask6$map)  
#      value  count
# [1,]     1 589960 --> acqua 
# [2,]     2 399903 --> neve 
# [3,]     3 344189 --> vegetazione
# [4,]     4 739548 --> ghiaccio



# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 561438 + 644303 + 577552 + 290307
s1 # = 2073600, questo valore deve essere uguale per tutti 

#per lalcolare la proporzione facciamo la frequenza fratto il totale
prop1 <- freq(CoAlask1$map)/ s1
prop1
#            value     count
# [1,] 4.822531e-07 0.2707552 = proporzione acqua 
# [2,] 9.645062e-07 0.3107171 = proporzione neve 
# [3,] 1.446759e-06 0.2785262 = proporzione vegetazione
# [4,] 1.929012e-06 0.1400014 = proporzione ghiaccio 
          
prop2 <- freq(CoAlask2$map) / s1
prop2
#             value     count
# [1,] 4.822531e-07 0.2792467 = proporzione acqua
# [2,] 9.645062e-07 0.3108912 = proporzione vegetazione
# [3,] 1.446759e-06 0.2370877 = proporzione neve 
# [4,] 1.929012e-06 0.1727744 = proporzione ghiaccio

prop3 <- freq(CoAlask3$map) / s1
prop3
#            value     count
# [1,] 4.822531e-07 0.3426292 = proporzione acqua
# [2,] 9.645062e-07 0.2671957 = proporzione vegetazione
# [3,] 1.446759e-06 0.2013243 = proporzione ghiaccio
# [4,] 1.929012e-06 0.1888508 = proporzione neve 

prop4 <- freq(CoAlask4$map) / s1
prop4
#            value     count
# [1,] 4.822531e-07 0.2167790 = proporzione ghiaccio
# [2,] 9.645062e-07 0.1000289 = proporzione neve
# [3,] 1.446759e-06 0.3204514 = proporzione vegetazione 
# [4,] 1.929012e-06 0.3627406 = proporzione acqua 

prop5 <- freq(CoAlask5$map) / s1
prop5
#            value     count
# [1,] 4.822531e-07 0.1398674 = proporzione ghiaccio
# [2,] 9.645062e-07 0.2935161 = proporzione acqua 
# [3,] 1.446759e-06 0.1897955 = proporzione neve 
# [4,] 1.929012e-06 0.3768210 = proporzione vegetazione 

prop6 <- freq(CoAlask6$map) / s1 
prop6
#             value     count
# [1,] 4.822531e-07 0.2845100 = proporzione acqua 
# [2,] 9.645062e-07 0.1928545 = proporzione neve 
# [3,] 1.446759e-06 0.1659862 = proporzione vegetazione
# [4,] 1.929012e-06 0.3566493 = proporzione ghiaccio 

#mettiamo in proporzione le frequenze per trovare dei valori in percentuale
# prima colonna dove mettiamo i fattori doce ci sarà ghiaccio e acqua
# seconda colonna mettiamo la percentuale corrispondente 
# usiamo la funzione Dataframe che ci crea una tabellina 

# si possono usare anche le percentuali, moltiplicando per 100 le proporzioni 
# ora generiamo un dataset che in R si chiama dataframe 
# mettiamo in colonna dei fattori che sono delle variabili categoriche
# ho sommato ghiaccio e neve per avere dati più chiari sulla situazione temporale, come anche vegetazione e nuovole 
cover <- c("ghiaccio + neve ", "acqua", "vegetazione + nuvole")
percent_1986 <- c(45.07, 27.07, 27.87)
percent_1995 <- c(40.97, 27.92, 31.08)
percent_2001 <- c(39.01, 34.26, 26.71)
percent_2005 <- c(21.67, 36.27, 42.04)
percent_2013 <- c(32.95, 29.35, 37.68)
percent_2019 <- c(35.66, 28.45, 35.87)

# per crare il nostro data Frames uso la funzione data.frame
percentages <- data.frame(cover, percent_1986, percent_1995, percent_2001, percent_2005, percent_2013, percent_2019)
percentages
#                  cover percent_1986 percent_1995 percent_2001 percent_2005 percent_2013 percent_2019
# 1     ghiaccio + neve         45.07        40.97        39.01        21.67        32.95        35.66
# 2                acqua        27.07        27.92        34.26        36.27        29.35        28.45
# 3 vegetazione + nuvole        27.87        31.08        26.71        42.04        37.68        35.87


# ora tracciamo i grafici 
# library ggplot2
# usiamo la funzione ggplot = del nostro file
# e il colore si riferisce a quali oggetti vogliamo descrivere nel nostro grafico
ggplot(percentages, aes(x=cover, y=percent_1986, color=cover)) + geom_bar(stat="identity", fill="violet")
ggplot(percentages, aes(x=cover, y=percent_1995, color=cover)) + geom_bar(stat="identity", fill="yellow")
ggplot(percentages, aes(x=cover, y=percent_2001, color=cover)) + geom_bar(stat="identity", fill="pink")
ggplot(percentages, aes(x=cover, y=percent_2005, color=cover)) + geom_bar(stat="identity", fill="blue")
ggplot(percentages, aes(x=cover, y=percent_2013, color=cover)) + geom_bar(stat="identity", fill="orange")
ggplot(percentages, aes(x=cover, y=percent_2019, color=cover)) + geom_bar(stat="identity", fill="green")

# metto in un unico grafico tutte le date posizionandolo in orizzontale
C1 <- ggplot(percentages, aes(x=cover, y=percent_1986, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_flip()
C2 <- ggplot(percentages, aes(x=cover, y=percent_1995, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C2 + coord_flip()
C3 <- ggplot(percentages, aes(x=cover, y=percent_2001, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C3 + coord_flip()
C4 <- ggplot(percentages, aes(x=cover, y=percent_2005, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C4 + coord_flip()
C5 <- ggplot(percentages, aes(x=cover, y=percent_2013, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C5 + coord_flip()
C6 <- ggplot(percentages, aes(x=cover, y=percent_2019, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C6 + coord_flip()
# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
grid.arrange(C1 + coord_flip(), C2 + coord_flip(), C3 + coord_flip(), C4 + coord_flip(), C5 + coord_flip(), C6 + coord_flip(), nrow=2)


#ptovo a modificare il grafico cambiando le coordinate
C1 <- ggplot(percentages, aes(x=cover, y=percent_1986, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_polar(theta = "x", direction=1 )
C1 <- ggplot(percentages, aes(x=cover, y=percent_1986, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C1 + coord_polar(theta = "x", direction=1 )
C2 <- ggplot(percentages, aes(x=cover, y=percent_1995, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C2 + coord_polar(theta = "x", direction=1 )
C3 <- ggplot(percentages, aes(x=cover, y=percent_2001, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C3 + coord_polar(theta = "x", direction=1 )
C4 <- ggplot(percentages, aes(x=cover, y=percent_2005, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C4 + coord_polar(theta = "x", direction=1 )
C5 <- ggplot(percentages, aes(x=cover, y=percent_2013, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C5 + coord_polar(theta = "x", direction=1 )
C6 <- ggplot(percentages, aes(x=cover, y=percent_2019, fill=cover)) + geom_bar(stat="identity") + theme_minimal()
C6 + coord_polar(theta = "x", direction=1 )
# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
grid.arrange(C1 + coord_polar(theta = "x", direction=1 ), C2 + coord_polar(theta = "x", direction=1 ), C3 + coord_polar(theta = "x", direction=1 ), 
             C4 + coord_polar(theta = "x", direction=1 ), C5 + coord_polar(theta = "x", direction=1 ), C6 + coord_polar(theta = "x", direction=1 ))




