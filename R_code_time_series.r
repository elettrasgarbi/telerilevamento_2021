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














