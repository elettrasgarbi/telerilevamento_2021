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
 
# unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)

#set.seed() would allow you to attain the same results...
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#class1: agriculture
#class2: forest 

d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#frequencies
freq(d1c$map)
# value  count
# [1,]     1 307392
# [2,]     2  33900

# ora calcoliamo la proporzione 
#facciamo la somma dei valori 
s1 <- 307392 + 33900
s1
# [1] 341292

prop1 <- freq(d1c$map) / s1
prop1
# proporzione foresta:0.90067157
# proporzione agricolo: 0.09932843

s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
# proporzione forest:0.5219476
# proporzione agricolo: 0.4780524

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
# usiamo la funzione ggplot 
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="violet")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="yellow")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="green")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="yellow")
# uso l funzione grid.arrange per mettere i grafici in una pagina  
grid.arrange(p1, p2, nrow=1)




