Carpeta donde pondre los scripts desarrollados por Ana.
Por ahora son los borradores de los scripts, todos funcionan pero se peuden optimizar y mejorar para que sean mas claros y optimizados

Archivos (breve explciacione):
 - rellenar_filtrar_otus: rellena NAs de los nombres de los OTUs en el diccionario y se hacen archivos para los OTUs que estan en el 80% de las mustras, los que representan el 20% en almenos una muestra y los que mas varianza tienen(>1e-06, valor variable)
 - filtracion_metadatos: quitamos los metadatos (las columnas) que no nos interesan. Este es un script que puede hacerse mas extenso cuando se hagan mas filtracioens de metadatos
 - exploracion_datos_phyloseq: expoloracion de los datos con el paquete phyloseq
 - diccionario_otus: creacion de un archivo que ser el diccionario de los OTUs a partir de un archivo txt con la tabla de samples-reads of OTU
 - creacion_tabla_otus: a partir de la tabla samples-reads of OTU y el diccionario de OTUs creamos la tabla final de samples-reads
 - creacion_metadata: filtramos algunas samples de las que no tenemos metadatos y quitamos algunas columnas innecesarias de los metedatos
 - FeatureSelectionNutrients: script para ver la correlacion de las variabels e intentar quitar alguna variable para eliminar variables redundantes
