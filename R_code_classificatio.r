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

# Dowload Solar Orbiter data and proceed futher!
# Grand Canyon 
# https://landsat.visibleeart.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition dow the Coloraqdo River and 

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

# con 4 classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)






