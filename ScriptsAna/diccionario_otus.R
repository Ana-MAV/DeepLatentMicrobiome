#Vamos a crear un diccionario de los nombres
#id, kingdom, phylum, class, order, familia, genero, especie
#esto tendria que ponerse al final en una funcion, cuando lo ponga bonito


setwd("C:/Users/anama/OneDrive/Documentos/2020-2021/practicas/transcurso/dietstudy_analyses-master")

#install.packages("tidyverse")
library(tidyverse)  

otus = read.table("data/microbiome/BURST.tax.txt",header=TRUE,sep="\t")


fila_otus = otus$taxonomy
len_final=9
#inicializamos el dataframe
dict_otus = data.frame(ID=character(),
                       name=character(),
                       otu_order=integer(),
                       kingdom=character(),
                       phylum=character(),
                       class=character(),
                       order=character(),
                       family=character(),
                       genus=character(),
                       specie=character(),
                       subspecie=character())
i = 1
for(fila in fila_otus) {
  categories = strsplit(fila,";")[[1]]
  #print(length(categories))
  otu_order_fila = length(categories)
  #print(otu_order_fila)
  categories= lapply(categories, function(x)substring(x,4,nchar(x)))
  categories = prepend(categories, i)
  i = i+1
  #print(length(categories))
  #print(categories)
  if (length(categories)!=len_final){
    categories = c(categories,rep(NA,len_final-length(categories)))
  }
  #print(categories)
  dict_otus <- add_row(dict_otus,
                       name=fila,
                       otu_order=otu_order_fila,
                       ID=as.character(categories[[1]]),
                       kingdom=categories[[2]],
                       phylum=categories[[3]],
                       class=categories[[4]],
                       order=categories[[5]],
                       family=categories[[6]],
                       genus=categories[[7]],
                       specie=categories[[8]],
                       subspecie=categories[[9]])
}
#lo pasamos a un archivo este diccionario
write.csv(dict_otus,"resultados_ana/otus_dictionary.csv",row.names=FALSE)