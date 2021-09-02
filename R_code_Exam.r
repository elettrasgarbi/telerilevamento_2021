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
# Funzione lapply: applica alla lista dei file una funzione (raster) 
import <- lapply(clist,raster)
# per ottenre le informazioni sui file
import
# Funzione stack: raggruppa e rinomina, in un unico pacchetto, i file raster separati
TGa <- stack(import)
# Funzione per avere le info sul file
TGa
# Funzione plot: del singolo file
plot(TGa)
# Funzione plotRGB: crea plot con immagini sovrapposte
plotRGB(TGa, 1, 2, 3, stretch="hist")
# Funzione ggr: plotta file raster in differenti scale di grigio, migliorando la qualità dell'immagine e aggiungengo le coordinate spaziali sugli assi x e y
ggRGB(TGa, r=3, g=2, b=1, stretch="hist) # "hist": amplia i valori e aumenta i dettagli







