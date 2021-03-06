# R_code_multivariate_analysis2.r

setwd("C:/lab/") # Windows

# abbiamo scaricato l'immagine del solar-orbital-data e scaricata su lab 
# usiamo la funzione BRIK, che importa l'immagine a tre livelli fuori da erre 
# BRIK √® una funzione dento la libreria raster quindi la attiviamo 

library(raster)
library(RStoolbox)
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#utilizziamo la funzione aggregate
#fact= quante volte vogliamo diminuire o aumentare la grandezza dei pixel 
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

#ora abbiamo dei pixel di 300 x 300
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# funzione pca = principal comonents analysis = prendiamo i dati originali e passimao un asse sulla variabilit√† maggiore e una su quella minore 
# la funziona va a compattere la funzione in un numero minore di bande 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#funzione summery = ci da un sommario del nostre modello 
summary(p224r63_2011res_pca$model)
#Importance of components:
#                          Comp.1      Comp.2       Comp.3       Comp.4
#Standard deviation     1.2050671 0.046154880 0.0151509526 4.575220e-03
#Proportion of Variance 0.9983595 0.001464535 0.0001578136 1.439092e-05
#Cumulative Proportion  0.9983595 0.999824022 0.9999818357 9.999962e-01
#                             Comp.5       Comp.6       Comp.7
#Standard deviation     1.841357e-03 1.233375e-03 7.595368e-04
#Proportion of Variance 2.330990e-06 1.045814e-06 3.966086e-07
#Cumulative Proportion  9.999986e-01 9.999996e-01 1.000000e+00

p224r63_2011res_pca
#abbiamo tutte le infomarzioni
dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")



