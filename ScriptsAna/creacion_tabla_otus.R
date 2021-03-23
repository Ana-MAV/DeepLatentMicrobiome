#vamos a crear con este scipt la tabla de los otus
#1-hay que quitar las columnas de Blank porque no tenemos nada de datos sobre esas personas o muestras
#2-hay que dividirlas en diferentes niveles de taxonomia
#3-guardar las tablas en una carpeta

setwd("C:/Users/anama/OneDrive/Documentos/2020-2021/practicas/transcurso/dietstudy_analyses-master")
library(dplyr)

#importar el diccionario
dictionary <- read.csv("resultados_ana/otus_dictionary.csv")

#importamos la tabal de otus
original_table <- read.table("data/microbiome/BURST.tax.txt",header = TRUE,sep="\t")

#eliminamos las columnas de Blank(2-13)
filtered_table <- subset(original_table, select = -c(2:13) )

#traducimos la primera columna de la tabla (filtered_table)
ids <- c()
for (otu in filtered_table$taxonomy){
  ids <- append(ids, dictionary[dictionary$name==otu, 1])
}
filtered_table <- data.frame(otuids=ids, filtered_table)
filtered_table$taxonomy <- NULL

#guardamos la tabla entera sin separcion pero con traduccion
write.csv(filtered_table,"resultados_ana/otus_todosordenes.csv",row.names=FALSE)

#separamos por jerarquias
nivel <- 2 #nivel filo --> se va cambiando para ajustarlo al igual que el nombre de los archivos 
nueva_tabla <- filter(filtered_table, otuids==dictionary$ID & dictionary$otu_order==nivel)

#guardamos las tablas
write.csv(nueva_tabla,"resultados_ana/otus_filo.csv",row.names=FALSE)