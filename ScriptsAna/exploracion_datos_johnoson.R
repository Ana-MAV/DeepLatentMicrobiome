#script para explorar los datos que tenemos

#----------------------------
#en la carpeta de diet solo hay txts
#los vemos en bloc de notas o notepad++

#en la carpeta de functions tambien son solo txts

#en la carpeta de maps tenemos los mapeos de los IDs de los usuarios, pero no de los otus

#en la carpeta microbiome /identify_swapped_samples son cosas de las muestra
#como feature id salen los nombres de los otus, ningun identifciador
#lo mismo en la carpeta de microbiome/processed_average

#procrustes/combined_day_diet_files.Rmd --> un archvio Rstudio hecho para combinar los datos
#de las dietas de todas las otras carpetas y de todo el mundo
#siguen sin tener un OTUs ID ninguna d elas tablas de tax

#seq_counts son cosas de las fasta, su nombre, sus lineas, etc, pero no hay nada de OTUs
#seq_run names son los nombres de los archvios de las secuencias fasta

#----------------------------
#----------------------------
#ahora vamos a ver los datos que estan en la carpeta de Data con formato R.data
load("data/diet.responsive.bugs.Rdata")
#esto son datos de dieta y moo en muestras que no se de quien son

load("data/food_v_microbes_per_person_3day.RData")
#lo que tiene son las relaciones entre las comidas y los moo de cada sujeto (son 30 dataframes)
#con esa informacion, pero no se cual es la diferencia entre 3day y decay

load("data/food_v_microbes_per_person_decay.RData")
#creo que la diferencia es que el anterior son los primeros 3 dias y luego los otros
#este archvio y el anterior son resultados de un analisis especifico

load("data/LOOCV.prediction.results.RData")
#estos osn los resultados del test-data despues de hacer el modelo
#esto voy a suponer que es con el arbol

load("data/original.prediction.results.Rdata")
#otros resultados, pero no estoy muy segura la diferencia entre original y el LOOCV
#creo que estos son los labels verdaderos

load("data/prediction.results.Rdata")
#estos son las predicciones del modelo

load("data/species.to.test.Rdata")
#las especies (los nombres tal y como estan en lso archivos de Rdata)

load("data/test_personal_diet_dat.Rdata")
#son los datos de las personas, donde esta el mb y dt axis (microbiome y diet axis)
#Los mb y dt axis son las coordenadas en esos ejes (de la 1 a la 5) de las distancias entre microbiomas y dietas
#despues de pasar por un principal coordinates analysis
#que esto sirve para ver como de similares o disimilares son nuestras muestras para cada persona
#estos axis vienen de test_personal_diet_each_person_own_dist.R

load("data/test_personal_diet_taxastrings.Rdata")
#-tabla con el nombre en los OTUS y su nombre en los datos






###Me falta por ver los scripts de las figuras, la que crean las figuras y leerme de nuevo el paper
#sobretodo para ver en que se diferencia lo del 3 day y el decay, auqnue no me haga falta para los datos, para saberlo
#hacer la tabla de los 
