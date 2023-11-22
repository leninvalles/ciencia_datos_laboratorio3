#Importación del archivo .csv
#Pregunta1
library(readr)
library(dplyr)
epa_http <- read_table("epa-http.csv", col_names = FALSE)
View(epa_http)

#Verificar el tipo de dato
class(epa_http$X2)

#Se formateó el nombre de las columnas
colnames(epa_http) <- c("IP", "Tiempo", "Tipo", "URL", "Protocolo", "Codigo", "Bytes")

#Corroboramos si se han aplicado bien los cambios
class(epa_http$Tiempo)

#Se formateó el valor "-" por "0"
epa_http$Bytes <- replace(epa_http$Bytes, epa_http$Bytes == "-", 0)

#Se formateó el tipo de valor de la columna Bytes a numérico
epa_http$Bytes <- as.numeric(epa_http$Bytes)

#Se formateó el tipo de valor de la columna Codigo a factor
epa_http$Codigo <- as.factor(epa_http$Codigo)

#Se formateó el tipo de valor de la colunma Tiempo a fecha
epa_http$Tiempo <- as.POSIXct(epa_http$Tiempo, format = "[%d:%H:%M:%S]", tz = "CET")


#Pregunta2
#Aplicamos el filtro teniendo en consideración solo respuestas 200, 302, 304
filtro3 <- filter(epa_http, Codigo == 200 | Codigo == 302 | Codigo == 304)
View(filtro3)

#Comprobamos si se han aplicado correctamente los filtros
unique(filtro3$Codigo) 



#Pregunta3
#Utilizando el método Table organizaremos los métodos GET, HEAD, POST midiendo su frecuencia en relación a la columna "Tipo"
filtro5 <- table(epa_http$Tipo)
#Visualizar el filtro
View(filtro5)
#Comprobamos si se han aplicado correctamente los filtros
unique(filtro5$Codigo)




#Pregunta4
#Grafico de Cantidad de Peticiones HTTP 
dato <-  data.frame(filtro5)
View(dato)

barplot(dato$Freq, names.arg = dato$Var1, ylab = "Frecuencia", xlab = "Metodo HTTP", main = "Cantidad de Peticiones HTTP")


#Pregunta5
ggplot2::ggplot(data=epa_http)+ geom_histogram(aes(x = TIME_STAMP),binwidth= 500, col='black', fill='green', alpha=0.4)+ ggtitle('Peticiones a lo Largo del Tiempo')





#Pregunta6
library(dplyr)
library(mltools)  
library(data.table)
library(readr)
library(mltools)
View(epa_http)


epa_http_one_hot <- one_hot(as.data.table(epa_http), sparsifyNAs = TRUE)

#resultado <- kmeans(epa_http2, centers = 2)
epa_http2 <- epa_http_one_hot
resultado <- kmeans(na.omit(epa_http2), centers = 2)

epa_http2$IP <- NULL
epa_http2$Tipo <- NULL
epa_http2$URL <- NULL
epa_http2$Tiempo <- NULL
epa_http2$Protocolo <- NULL

#df_sin_na <- subset(df, !is.na(x) & !is.na(y))
epa_http2 <- epa_http2[complete.cases(epa_http2), ]
plot(epa_http_one_hot, col=resultado$cluster)

