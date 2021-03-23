setwd("C:/Users/anama/OneDrive/Documentos/2020-2021/practicas/transcurso/dietstudy_analyses-master")

library("phyloseq")
library("ggplot2")      # graphics
library("readxl")       # necessary to import the data from Excel file
library("dplyr")        # filter and reformat data frames
library("tibble")       # Needed for converting column to row names
library("taxize")       #para rellenar campos vacios de los otus

#Es un script para 3 cosas:
## 1. rellenar los OTUs que se puedan
## 2. hacer graficas #lo dejamos para otro momento
## 3. Filtrar por #otus (20% de las muestras, 80% en las muestras, mayor variacion)

tax_mat<- read_excel("resultados_ana/datos_especies.xlsx", sheet = "otus_dictionary")

#-----------------------------------------
#esto se puede mejorar usando lo de phyloseq como en el codigo de la profesora
#te preguntara cosas probablemente cuando coincida con varias cosas
#no arregla todas, pero las que no arregle se tendran que hacer manualmente
tax_mat_copia <- tax_mat
columnas = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Specie") #no se puede buscar la subespecie
for (row in 1:nrow(tax_mat)){
  i <- 8
  fila <- tax_mat[row,]
  while(TRUE){
    if (is.na(tax_mat[row,i])){
      cat(row,",",i)
      print(tax_mat[row,i+1])
      if(is.na(tax_mat[row,i+1])){#esto significa que no se encontro las cosas y se debe intentar hacer a mano
        break
      }
      busqueda <- as.data.frame(tax_name(sci=tax_mat[row,i+1],get=columnas[i-1],db="both",verbose=FALSE))
      if(is.na(busqueda[1,length(busqueda)])){
        tax_mat[row,i] <- busqueda[1,length(busqueda)]
      }else{
        tax_mat[row,i] <- busqueda[2,length(busqueda)]
      }
    #si las 2 son NA, se añadira un NA por lo que se quedara igual
    }
    i <- i-1
    if (i==1){
      break
    }
  }
}

#rellenamos manualmente las que no se han clasificado
#como vemos, el mayor problema es que hay muchas que no estan clasificadas
#tax_mat[21,7] <- "unclassified Lachnospiraceae"
#tax_mat[96,7] <- "unclassified Lachnospiraceae"
#tax_mat[119,6] <- "Clostridiales incertae sedis"
#tax_mat[121,7] <- "unclassified Ruminococcaceae"
#tax_mat[124,6] <- "unclassified Clostridiales"
#tax_mat[124,7] <- "unclassified Clostridiales"
#tax_mat[126,6] <- "unclassified Burkholderiales"
#tax_mat[126,7] <- "unclassified Burkholderiales"
tax_mat[139,6] <- "Ruminococcaceae" ####Este deberia haber funcionado, hay que mirarlo!!!!!!!
#hay algun problema cuando no lo hay en el primero, y si en el segundo o en cuando se mira la familia
tax_mat[152,6] <- "Ruminococcaceae"
tax_mat[174,6] <- "Ruminococcaceae"
tax_mat[200,6] <- "Ruminococcaceae"
#tax_mat[207,6] <- "Clostridiales incertae sedis" #en este tipo no hay error
#tax_mat[209,7] <- "unclassified Lachnospiraceae"
tax_mat[235,7] <- "Bacteroides" ##Est atambien sale mal, y esta en itis, es raro
tax_mat[235,6] <- "Bacteroidaceae"
tax_mat[239,6] <- "Ruminococcaceae"#lo mismo, esta en ncbi
#tax_mat[245,7] <- "unclassified Ruminococcaceae"
#tax_mat[278,7] <- "unclassified Erysipelotrichaceae"
#tax_mat[283,7] <- "unclassified Lachnospiraceae"
#288 es un unclassfied Clostidiales
#293 unclassified Ruminococcaceae
#306 unclassified Lachnospiraceae
#317 unclassified Lachnospiraceae
#321 unclassified bacteria
#355 unclassified Erysipelotrichaceae
#361 unclassified Lachnospiraceae
tax_mat[389,7] <- "Eubacterium"
#441 unclassified Clostridiales
#443 unclassified Erysipelotrichaceae
#454 unclassified Eubacteriaceae
#466 y 472 unclassified Lachno...
#a partir de aqui solo voy a señalar los que estan mal
#tax_mat[719,6] <- "Clostridiales incertae sedis"
#tax_mat[743,6] <- "Clostridiales incertae sedis"
tax_mat[947,6] <- "Ruminococcaceae"
#tax_mat[993,6] <- "Clostridiales incertae sedis"
tax_mat[1320,6] <- "Eubacteriaceae" #en esta te pregunatba
tax_mat[1320,7] <- "Eubacterium" #Esto estaba mal puetso en la original
tax_mat[1578,6] <- NA
tax_mat[1698,6] <- NA
tax_mat[1798,6] <- NA
tax_mat[1800,6] <- NA
tax_mat[1824,4] <- "Oscillatoriophycideae"
tax_mat[1825,4] <- "Cyanophyceae" #este estaba en el ncbi
tax_mat[1940,7] <- "Clostridium"#mal en los datos originales
tax_mat[1940,6] <- "Clostridiaceae"
tax_mat[2920,6] <- "Gottschalkiaceae"#estaba en el NCBI
tax_mat[3557,6] <- "Pyrinomonadaceae" #estaba en el NCBI
tax_mat[3557,5] <- "Blastocatellales"
tax_mat[3558,4] <- "Mollicutes"
tax_mat[3558,3] <- "Tenericutes"
tax_mat[3774,4] <- "Oscillatoriophycideae"
tax_mat[3775,4] <- "Oscillatoriophycideae"
tax_mat[3827,7] <- "Bacillus"
tax_mat[3974,6] <- NA
tax_mat[3987,7] <- "Clostridium"
tax_mat[4041,6] <- "Geminicoccaceae"
tax_mat[4041,5] <- "Rhodospirillales"
tax_mat[4556,6] <- "Terrimicrobium"#estaba en el ncbi
tax_mat[4556,5] <- "Terrimicrobiales"#tambien estaba en el ncbi


#guardamos este diccionario  corregido
write.csv(tax_mat,"diccionario_otus_corregido.csv",row.names=FALSE)

#importamos este csv

#Ya esta perfecta, asi que podemos trabajar con tax_mat


#-----------------------------------------
#dejamos lo de hacer las graficas para otro momento

#-----------------------------------------
#filtramos los otus
#####http://joey711.github.io/phyloseq-demo/phyloseq-demo.html
otu_mat<- read_excel("resultados_ana/datos_especies.xlsx", sheet = "otus_todosordenes")
tax_mat<- read.csv("resultados_ana/diccionario_otus_corregido.csv")
samples_df <- read_excel("resultados_ana/datos_especies.xlsx", sheet = "todos_metadatos")

otu_mat <- otu_mat %>%tibble::column_to_rownames("otuids")
tax_mat <- tax_mat %>%tibble::column_to_rownames("ID")
samples_df <- samples_df %>%tibble::column_to_rownames("X.SampleID")

otu_mat <- as.matrix(otu_mat)
tax_mat <- as.matrix(tax_mat)

OTU = otu_table(otu_mat, taxa_are_rows = TRUE)
TAX = tax_table(tax_mat)
samples = sample_data(samples_df)

moo <- phyloseq(OTU, TAX, samples)
moo

#visualizamos los samples
sample_names(moo)
#lso rangos del diccionario
rank_names(moo)
#las variables de las samples
sample_variables(moo)

#exploramos un poco las tablas
otu_table(moo)[1:5,1:5]
tax_table(moo)[1:5,]
sample_data(moo)[1:5,1:5]
#de phy_tree y refseq no tenemos nada

#----------------------------
#vamos a coger solo nivel especie con los otus
#Cogemos las especies que no tengan NA
moo_especie <- subset_taxa(moo, !is.na(specie) & is.na(subspecie))
moo_especie
write.csv(otu_table(moo_especie),"resultados_ana/datos_otus_filtrados/otu_table_especies.csv")
write.csv(tax_table(moo_especie),"resultados_ana/datos_otus_filtrados/tax_table_especies.csv")


#transformamos a abundancia relativa
moo_abund <- transform_sample_counts(moo_especie, function(x) x/sum(x))
write.csv(otu_table(moo_abund),"resultados_ana/datos_otus_filtrados/otu_table_especies_abundancia.csv")

#---------------

#este no me sale por alguna razon
#only take OTUs that represent at least 20% of reads in at least one sample. 
moo_0 <- filter_taxa(moo_abund, function(x) (x > 0.20), TRUE)
moo_0

#---------------
#cogemos lso otus que estan en al menos el 80% de los samples
moo_80 <- prune_taxa(taxa_sums(moo_especie) > 0.8*nsamples(moo_especie), moo_especie)
write.csv(otu_table(moo_80),"resultados_ana/datos_otus_filtrados/otu_table_especies_80.csv")
write.csv(tax_table(moo_80),"resultados_ana/datos_otus_filtrados/tax_table_especies_80.csv")

moo_80_abund <- transform_sample_counts(moo_80, function(x) x/sum(x))
write.csv(otu_table(moo_80_abund),"resultados_ana/datos_otus_filtrados/otu_table_especies_80_abundancia.csv")
#salen 312 otus que vamos a trabajar (nivel especie)


#cogemos los otus con mayor varianza en los samples, para ello tenemos que transformar a abundancia relativa
moo_varianza <- filter_taxa(moo_abund, function(x) var(x) > 1e-06, TRUE)
write.csv(otu_table(moo_varianza),"resultados_ana/datos_otus_filtrados/otu_table_especies_variabilidad_abundancia.csv")
write.csv(tax_table(moo_varianza),"resultados_ana/datos_otus_filtrados/tax_table_especies_variabilidad_abundancia.csv")

#De aqui obtenemos 131 especies (va cambiando segun la varianza que pongas)