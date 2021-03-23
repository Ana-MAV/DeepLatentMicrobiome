#vamos a filtrar los metadatos, este codigo se ira probablemente
#alargando segun se vaya extendiendo el estudio

setwd("C:/Users/anama/OneDrive/Documentos/2020-2021/practicas/transcurso/dietstudy_analyses-master")

metadatos <- read.csv("resultados_ana/todos_metadatos.csv")

#Las columnas de nutientes son las 2-26, 30-41, 50, 55, 63-64
#las que son 65 y 66 son added, por lo que supongo que estaran incluidas en las otras columnas de vitamina B y vitamina E
col_nutrientes <- c(1:26,30:41,50,55,63:64)
metadatos_nutrientes <- metadatos[,col_nutrientes]
write.csv(metadatos_nutrientes,"resultados_ana/metadatos_nutrientes.csv",row.names=FALSE)