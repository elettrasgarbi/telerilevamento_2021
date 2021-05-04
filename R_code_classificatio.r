# R_code_classificatio.r

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

#  Dowload an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images

sun <- brick("sun.png")

# Unsupervised classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)
