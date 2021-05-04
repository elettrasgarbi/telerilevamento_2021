#R_code_knitr.r
setwd("C:/lab/")

library(knitr)

#abbiamo preso il codice di greenland, copiati, incollati sul blocco note e salvati nella cartella lab nominando il file R_code_greenland.r

stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#parte con la generazione del report e le firgure 
