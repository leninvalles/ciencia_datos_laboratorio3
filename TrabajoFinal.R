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

#Corroboramos la correcta aplicación de los cambios
class(epa_http$Tiempo)

#Realizamos el formateo el valor "-" por "0"
epa_http$Bytes <- replace(epa_http$Bytes, epa_http$Bytes == "-", 0)

#Realizamos el formateo del tipo de valor de la columna Bytes a numérico
epa_http$Bytes <- as.numeric(epa_http$Bytes)

#Procedemos al formateo del tipo de valor de la columna Codigo a factor
epa_http$Codigo <- as.factor(epa_http$Codigo)

#Procederemos a Formatear el tipo de valor de la colunma Tiempo a fecha
epa_http$Tiempo <- as.POSIXct(epa_http$Tiempo, format = "[%d:%H:%M:%S]",tz="CET")

#
#
#2. Identificar el número único de usuarios que han interactuado directamente con
#el servidor de forma segregada según si los usuarios han tenido algún tipo de
#error en las distintas peticiones ofrecidas por el servidor.
#
#
#Aplicamos el filtro para los valores de Codigo. El filtro es aplicado teniendo 
#en consideración solo respuestas 200, 302 y 304. Las respuestas 400,403,404,
#500 y 501 no se toman en cuenta porque indica que el servidor no puede procesar
#la solicitud, por lo cual se percibe como un error del cliente (usuario).
filtro3 <- filter(epa_http, Codigo == 200 | Codigo == 302 | Codigo == 304)
View(filtro3)

#Comprobamos si se han aplicado correctamente los filtros.
unique(filtro3$Codigo)
#
#
#3. Analizar los distintos tipos de peticiones HTTP (GET, POST, PUT, DELETE)
#gestionadas por el servidor, identificando la frecuencia de cada una de estas.
#Repetir el análisis, esta vez filtrando previamente aquellas peticiones
#correspondientes a recursos ofrecidos de tipo imagen.
#
#















