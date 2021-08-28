#R_code_complete.r - Telerilevamento Geo - Ecologico

#------------------------------------------------------------------------------------------------------------------

#summary:

# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification
# 7. Rcode ggplot 2
# 8. R code vegetation indices
# 9. R code land cover
# 10. R code variability


#---------------------------------------------------------------------------------------------------------------------
# Il mio primo codice in R per il telerilevamento!

# install.packages("raster")
library(raster)
setwd("C:/lab/") # Windows

#questa funzione serve a importare un'immagine satellitare
# brick = blocco dei raster
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

# color change
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)

# color change -> new
cl <- colorRampPalette(c("purple","yellow","blue")) (100)
plot(p224r63_2011, col=cl)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

# dev.off will clean the current graph
dev.off()

# $=legare
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

dev.off()

#par = serve a stabilire come voglio fare il plottaggio
# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 row, 1 columns
par(mfrow=c(2,1)) # if you are using columns first: par(mfcol...)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot the first four bands of landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands...
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow)=c(2,2))
#blue
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
 
# green
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)   
    
# red
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

# yellow
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

# Visualizing data by RGB plotting
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

#RGB natural color immagie 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Exercise: mount a 2X2 multiframe
pdf("il_mio_primo_pdf-pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# stretching the function
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#par natural colours, flase colours, and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#install.packages("RStoolbox")
# library(RStoolbox)

# Multitemporal set
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
# andiamo a plottare le singole bande 
plot(p224r63_1988)

# mettiamo numeri piuttosto che nomi dei colori perchè chi lo ha programmato ha deciso così
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") # stretch serve a stirare i nostri valori 
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

# hist
#creare un par (2,2) con 1988 e 2011
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

# creo il pdf
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()
    

# comando per unire tutti i pdf creati in questo momento
bash scripting
pdftk*.pdf cat output mergedfile.pdf

# --------------------------------------------------------------------------------------------------------------------------------------
# 2. R code time series

# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

#install.packages("raster")
library(raster)
setwd("C:/lab/greenland") # Windows

# importiamo i dati tif uno a uno contenuti nella cartella greenland
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)

lst_2005 <- raster ("lst_2005.tif")
plot(lst_2005)

lst_2010 <- raster ("lst_2010.tif")
plot(lst_2010)

#sovrapposizione delle 3 immagini 2000,2005 e 2010
plotRGB(TGr, 1, 2, 3, stretch="Lin")

lst_2015 <- raster ("lst_2015.tif")
plot(lst_2015)

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#invece che importare i singoli dati, si usa la funzione stack e usarli tutti insieme 
rlist <- list.files(pattern="tif")
rlist
import <- lapply(rlist,raster)
TGr <- stack(import)
plot(TGr)

#plottiamo usando direttamente i dati uniti con uno stack
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

#installiano un'altra library
library(rasterVis)

levelplot(TGr$lst_2000) #con level plot abbiamo una gamma di colori molto più ampia    
#colour and palette per vedere multi temporalmente cosa è successo in queste zone 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
#rinominiamo i vari layer all'interno della nostra immagine 
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#main è l'argomento e lo mettiamo tra virgolette 
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# scarichiamo meal
# creiamo una lista di file mealtlist che hanno un pattern comune, cioè melt
# usiamo la funzione lapply alla lista che abbiamo nominanto per importarli
# stack funzione che mi unisce tutti i file 
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt <- stack(melt_import)
melt
levelplot(melt) # notiamo differenze tra le strisce di ghiaccio nei vari anni 

# ora applichiamo l'algebra applicata alle matrici 
#vogliamo fare la sottrazione tra il primo e l'ultimo dato 
# $ il dollaro mi lega il file originale al file interno 
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
# creo una nuoca colour and palette 
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb) # zone rosse dove c'è stato uno scioglimento dei ghiacci 
# usiamo level per avere una gamma di colori più dettagliata 
levelplot(melt_amount, col.regions=clb)

#installare un nuovo pacchetto knitr
install.packages("knitr") #https://cran.r-project.org/web/packages/knitr/index.html

# -----------------------------------------------------------------------------------------------------------------------------
# 3. R code Copernicus data
#R_code_copernicus.r
#visualizzazione copernicus e login
#dowload ALBEDO e Vegetation properties

#install.packages("ncdf4")
library(raster)
library(ncdf4)

# Windows
setwd("C:/lab/") 

albedo <- raster ("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")
# adesso lo richiamo per visualizzare i dati
albedo 

#ora usiamo il plot e avendo un singolo strado decidiamo noi il colore 
cl <- colorRampPalette(c('blue','purple','yellow','orange'))(100) #
plot(albedo, col=cl)

#questo dato si può rivalutare con dei pixel un po' più grandi 
# ricampiono per aggregare più pixel = RICAMPIONAMENTO LINEARE 
# resampling
albedores <- aggregate(albedo, fact=100) #diminuisco l'informazione di 1000 volte 
plot(albedores, col=cl)

install.packages("knitr")
library(knitr)

install.packages("RStoolbox")
library(RStoolbox)

# ----------------------------------------------------------------------------------------------------------------------------------------

# 4. R code knitr
#R_code_knitr.r
setwd("C:/lab/")

library(knitr)

#abbiamo preso il codice di greenland, copiati, incollati sul blocco note e salvati nella cartella lab nominando il file R_code_greenland.r

stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#parte con la generazione del report e le firgure 

# ------------------------------------------------------------------------------------------------------------------------------------------

# 5. R code multivariate analysis
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

# ------------------------------------------------------------------------------------------------------------------------------

# 6. R code classification
# R_code_classification.r

setwd("C:/lab/") # Windows

# abbiamo scaricato l'immagine del solar-orbital-data e scaricata su lab 
# usiamo la funzione BRIK, che importa l'immagine a tre livelli fuori da erre 
# BRIK è una funzione dento la libreria raster quindi la attiviamo 

library(raster)
library(RStoolbox)
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# visualizziamo la nostra immagine RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

#pronti per fare una classificazione non supervisionata = Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
plot(soc$map)

# Unsupervised Classification with 20 classes
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

cl <- colorRampPalette(c('yellow', 'black', 'red'))(100)
plot(soc20$map,col=cl)

#  Dowload an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images

sun <- brick("sun.png")

# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

# Dowload Solar Orbiter data and proceed futher!
# Grand Canyon 
# https://landsat.visibleeart.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition dow the Coloraqdo River and 

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
#hist una funzione per allungare e strecciare la nostra immagine ancora di più
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#processo di classificazione con al funzione da utilizzare è unsuperClass
# 2 perchè il numero delle classi sono 2
# stiamo facendo un modello di classificazione 
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

# con 4 classi
#la descriminazione avviene solo a livello di riflettanza 
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#--------------------------------------------------------------------------------------------------------------------------------------

#7. R code ggplot 2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#---------------------------------------------------------------------------------------------------------------------------

# 8. R code vegetation indices
# R_code_vegetation_indices.r
# scarichiamo da virtuale le due immagine sullla cartella lab 
library(raster) # require(raster) che fa la stessa cosa di library
library(RStoolbox) # for vegetation indices calculation
# install.packages("rasterdiv") 
library(rasterdiv) # fore the worldwide NDVI

#install.packages("rasterVis")
library(rasterVis)
setwd("C:/lab/") # Windows

defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green
# ora le plottimao 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#andiamo a fare il primo indice
# per vedere i nomi delle varie mande, lanciare su r, defor 1 e poi defor 2 
defor1
# names      : defor1.1, defor1.2, defor1.3 
# per ogni pixer fare la differenza dell'infrarosso e rosse
#different vegetable index 
dvi1 <- defor1$defor1.1 - defor1$defor1.2
#dev.off()
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl, main="DVI at time 1")

#ora facciamo la stessa cosa per il defor2
defor2
#names      : defor2.1, defor2.2, defor2.3 
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")

# ora andiamo a vederli entrambi plottandoli insieme usando la funzione PAR
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# ora facciamo la differenza delle due mappe 
difdvi <- dvi1 - dvi2 
# mi dice che l'estensione delle due immagini non è la stessa, molto probabilmente una delle due immagini ha qualche pixer in più 
# ma non è un problema perchè calcolerà il dato nella loro intersezione 

# dev.off()
# andiamo ad evidenziare la differenza con colour and palette e abbiamo la mappa su una sola banda 
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
# dove la differenza è più forte avremo un colore rosso, viceversa un colore blu/bianco 
# un immagine a 16 b ha dei valori che vanno da 0 a 2^16= 65536
#quindi nel primo tempo ho 255 nella seconda 65535 e non ha senso confrontarle allora usiamo un altro indice
# NDVI = normalizzazione della somma, con questo comando possiamo comparare immagini che hanno valori diversi di entrata 
# il ranhe del NDVI ha sempre lo stesso range cioè minumo di -1 e massimo di +1
#si calcola 
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot (ndvi1, col=cl)

# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot (ndvi1, col=cl)

# nel pacchetto RStoolbox si trova la funzione spectralIndices che possiamo utilizzare per fare il calcolo 

# andiamo a calcoare i valori della seconda immagine e per vedere lancio il comando defor2 

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot (ndvi2, col=cl)

# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# stessa cosa anche per la seconda 
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# fare la differenza tra i due ndvi
difndvi <- ndvi1 - ndvi2

 

# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

#worldwide NDVI
plot(copNDVI)
# Pixel with values 253, 254  and 255 (water) will be set as Na's
# eliminiamo l'acqua dall'immagine 
# con i : diamo il range
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#una funzione all'interno del pacchetto rasterVis che fa una media dei valori
levelplot(copNDVI)
 

#ritento di riscrivere il codice 
# R_code_vegetation-indices
# carichiamo le librerie
library(raster)
library(RStoolbox) # for vegetation indices calculation
library(rasterdiv) # for the worldwide NDVI
library(rasterVis)
# settiamo la working directory
setwd("C:/lab/")
# carichiamo le immagini utilizzando la funzione brick
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
# b1= NIR, b2= red, b3= green

# visualizziamo le due immagini insieme creando un par
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# different vegetation index
defor1
# in questo modo otteniamo le informazioni relative all'immagine
# calcoliamo l'indice di vegetazione della prima immagine
dvi1 <- defor1$defor1.1 - defor1$defor1.2
# si ottiene una mappa formata da pixel che sono dati dalla differezza tra l'infrarosso e il rosso 
# visualizziamo la mappa con la funzione plot
plot(dvi1)
# questa mappa mostra lo stato di salute della vegetazione
# ora modifchiamo la colorRampPalette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
# visualizziamo l'immagine con i nuovi colori assegnati
plot(dvi1, col=cl)

# facciamo la stessa cosa per la seconda immagine
defor2
# in questo modo visualizziamo il nome delle bande associate a questa immagine
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
# visualizziamo l'immagine con i nuovi colori assegnati
plot(dvi2, col=cl)
# la parte gialla della mappa indica le zone in cui non è più presente vegetazione

# visualizziamo le due immagini assieme con la funzione par
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# facciamo la differenza tra le due mappe
difdvi <- dvi1 - dvi2
# utilizziamo una colorRampPalette diversa
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
# ottengo una mappa in cui dove la differenza è maggiore il colore sarà rosso per cui indica dove c'è stata unaperdita maggiore della vegetazione nel tempo

# ndvi1
# (NIR-RED) / (NIR+ RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)

ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)

# for vegetation indices calculation
# spectral indices
# con questa funzioni si calcolano tutti gli indice e vengono inseriti tutti in un'unica immagine
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)
# facciamo lo stesso per la seconda immagine
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# for the worldwide NDVI
plot(copNDVI)
# otteniamo una mappa del NDVI a livello globale
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
# questa funzione permette di modificare dei valori, in questo caso eliminiamo la parte dell'immagine relativa all'acqua
plot(copNDVI)

#rasterVis package needed
levelplot(copNDVI)

# -------------------------------------------------------------------------------------------------------------------------------------------

#9. R code land cover 
# R_code_land_cover.r
library(raster)
library(RStoolbox) #classification
# install.packages("gridExtra")
library(gridExtra) # for grid.arrange  plotting 
#mi permette di non far venir fuori errori tichiamando le due librerie 
library(ggplot2)
library(RStoolbox)

# install.packages("ggplot2")
library(ggplot2)
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

setwd("C:/lab/") # Windows

#NIR 1, RED 2, GREEN 3
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=3, b=2, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")


#per mettere le immagini una difianco all'altra 
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra 
# arrange = compone il nostro multiframe
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)
dev.oof() 

# unsupervised classification = l'inizio non viene supervisionato da noi, ma fa tutto il software
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)

#set.seed() would allow you to attain the same results...
#creiamo la seconda mappa prendendo la seconda immagine deford 2 
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)


#class1: agriculture
#class2: forest 

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#calcoliamo le frequenza dei pixer
#frequencies = funzione che va a calcolare la frequenza
freq(d1c$map)
# value  count
# [1,]     1 307392
# [2,]     2  33900

# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 307392 + 33900
s1
# [1] 341292 che deve essere uguale per tutti 

#per lalcolare la proporzione facciamo la frequenza fratto il totale
prop1 <- freq(d1c$map) / s1
prop1
# proporzione foresta:0.90067157
# proporzione agricolo: 0.09932843

s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
# proporzione forest:0.5219476
# proporzione agricolo: 0.4780524

#una cosa che si può fare è la percentuali

# prima colonna dove mettiamo i fattori doce ci sarà forest e agricolture
#seconda colonna mettiamo la percentuale corrispondente 
# usiamo la funzione Dataframe che ci crea una tabellina 

# si possono usare anche le percentuali, moltiplicando per 100 le proporzioni 
#ora generiamo un dataset che in R si chiama dataframe 
# mettiamo in colonna dei fattori che sono delle variabili categoriche = i due fattori sono la foresta e l'agricoltura 
cover <- c("Forest", "Agricolture")
percent_1992 <- c(90.06, 09.93)
percent_2006 <- c( 52.19, 47.80)

# per crare il nostro data Frames uso la funzione data.frame
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
# cover percent_1992 percent_2006
#1      Forest        90.06        52.19
#2 Agricolture         9.93        47.80

# let's plot them 
# usiamo la funzione ggplot = del nostro file
# color si riferisce a quali oggetti vogliamo descriminare nel nostro grafico
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="violet")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="yellow")

#voglio metterli in un unico grafico della prima e seconda data 
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="green")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="yellow")
# uso l funzione grid.arrange per mettere i grafici in una pagina  della gridextra già installato
grid.arrange(p1, p2, nrow=1)

#-------------------------------------------------------------------------------------------------------------------------------

# 10. R code variability

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

#la funzione scale_fill_viridis che utilizziano
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()

#se vogliamo mettere un titolo la funzione si chiama ggtitle
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

#proviamo a utilizzare magma come colorazione
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

# tutte le opzioni le vedo qui --> https://www.rdocumentation.org/packages/viridis/versions/0.6.1/topics/scale_fill_viridis
# tutte le zone vengono bene quando abbiamo una alta deviazione standard
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

#ogni plot precedente lo associamo a un oggetto
grid.arrange(p1, p2, p3, nrow = 1)


# --------------------------------------------------------------------------------------------------------------------------------------------------






























    
    
    

