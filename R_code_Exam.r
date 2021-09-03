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
levelplot(ACi,col.regions=cls, main="Variation ice cover in time", names.attr=c("1989","1995", "2001", "2005", "2013", "2019"))

#............................................................................................................................................................



#-------------------------------------------------------------------------------------------------------------------------------------------------------------

# MULTIVARIATE ANALYSIS

# 1. Le coppie di funzioni producono una matrice di scatterplot.

# Traccia le correlazioni tra le 3 bande del mio stack.
# I valori di correlazione degli indici vanno da 0 a 1: 1= correlazione, 0 = nessuna correlazione
# Plot di tutte le correlazioni tra bande di un dataset (matrice di scatterplot di dati, non immagini)
# La tabella riporta in diagonale le bande (sono le variabili)
pairs(ACi, main="Comparation with the function pairs")
# Result= 0.9
# Indice di correlazione: più le bande sono correlate e maggiore sarà la dimensione dei caratteri


# Importazione delle singole immagini per effettuare comparazioni
# Funzione: brick, importa i singoli file per avere dati e immagini a 3 bande
# Non utilizzo la funzione raster perchè successivamente farò l'analisi della PCA nella quale servono almeno 2 bande 
Columbia1989 <- brick("1 columbia_tm5_1986209_lrg.jpg")
Columbia1995 <- brick("2 columbia_tm5_1995202_lrg.jpg")
Columbia2001 <- brick("3 columbia_etm_2001258_lrg.jpg")
Columbia2005 <- brick("4 columbia_tm5_2005245_lrg.jpg")
Columbia2013 <- brick("5 columbia_oli_2013203_lrg.jpg")
Columbia2019 <- brick("6 columbiaglacier653_oli_2019172_lrg.jpg")



# 2. Analisi delle componenti principali

# PCA del ghiacciaio Columbia 1989
Columbia1989_pca <- rasterPCA(Columbia1989)
summary(Columbia1989_pca$model)
# Importance of components:
#                            Comp.1     Comp.2      Comp.3
# Standard deviation     109.2553346 59.9319584 27.67877126
# Proportion of Variance   0.7325536  0.2204302  0.04701622
# Cumulative Proportion    0.7325536  0.9529838  1.00000000
plotRGB(Columbia1989_pca$map,r=1,g=2,b=3, stretch="Hist")
plot(Columbia1989_pca$model) # per vedere il grafico

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

# confrontiamo le PCA ottenute dal 1989 al 2019
par(mfrow=c(2,3)) # 3 colonne e 2 righe
plotRGB(Columbia1989_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia1995_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# Multiframe con ggplot
Co1989 <- ggRGB(Columbia1989_pca$map,r=1,g=2,b=3, stretch="Hist")
Co1995 <- ggRGB(Columbia1995_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2001 <- ggRGB(Columbia2001_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2005 <- ggRGB(Columbia2005_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2013 <- ggRGB(Columbia2013_pca$map,r=1,g=2,b=3, stretch="Hist")
Co2019 <- ggRGB(Columbia2019_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(Co1989, Co1995, Co2001, Co2005, Co2013, Co2019, nrow=2)

