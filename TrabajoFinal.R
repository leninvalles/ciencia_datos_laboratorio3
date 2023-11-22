#******************************************************************************#
#                                                                              #
#        Lab 3 - Análisis de logs de servidor usando R (Parte II)              #
#                                                                              #
#           Gianpaul Custodio | Julio Fuerte | Lenin Valles                    #
#                                                                              #
#******************************************************************************#
#
#
#Preguntas de Investigación
#
#
#1. Descomprimir el fichero comprimido que contiene los registros del servidor, 
#y a partir de los datos extraídos, cargar en data frame los registros con las
#peticiones servidas.
#
#
#Procedemos a realizar la importación del archivo .csv
library(readr)
epa_http <- read_table("epa-http.csv", col_names = FALSE)
View(epa_http)

#Verificamos el tipo de dato referente a la columna de fecha y hora
class(epa_http$X2)

#Procedemos a formatear el nombre de las columnas
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")

#Realizamos el formateo el valor "-" por "0"
epa_http$Bytes <- replace(epa_http$Bytes, epa_http$Bytes == "-", 0)

#Realizamos el formateo del tipo de valor de la columna Bytes a numérico
epa_http$Bytes <- as.numeric(epa_http$Bytes)

#Procedemos al formateo del tipo de valor de la columna Codigo a factor
epa_http$Codigo <- as.factor(epa_http$Codigo)



