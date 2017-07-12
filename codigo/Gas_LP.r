
 # 12/ 07 /2017

 # Ubicacion de dispensadoras de Gas LP. 

 # Primero leemos los datos: 
install.packages(ggmap)
install.packages(readxl)
install.packages(leaflet)

require(ggmap)
require(readxl)
require(leaflet)


gasLP_DISTRIBUIDORES <- as.data.frame(read_excel("~/Git/gaslp/datos/gasLP_DISTRIBUIDORES.xlsx"))

# Creamos un Data Frame con las direcciones completas (calle _ Municipio _ Estado) para ggmap()

Gas_LP<- matrix(NA,nrow = length(gasLP_DISTRIBUIDORES[,1]),ncol = 1)


for(i in 1:length(gasLP_DISTRIBUIDORES[,1])){
  Gas_LP[i,1]<-paste0(gasLP_DISTRIBUIDORES[i,2], ", ",gasLP_DISTRIBUIDORES[i,3],", ",gasLP_DISTRIBUIDORES[i,1])
}

# Ahora, buscamos latitud y longitud de cada una de las direcciones

localiza<-data.frame()

for(i in 1:length(gasLP_DISTRIBUIDORES[,1])){
  dir<-paste0(gasLP_DISTRIBUIDORES$Estado[i]," , ",gasLP_DISTRIBUIDORES$Municipio[i]," , ",gasLP_DISTRIBUIDORES$Dirección[i])
  dire<-geocode(dir)
  geoloca<-data.frame(gasLP_DISTRIBUIDORES$Estado[i]," , ",gasLP_DISTRIBUIDORES$Municipio[i]," , ",gasLP_DISTRIBUIDORES$Dirección[i] ,latitud=dire$lat,longitud=dire$lon)
  localiza<-rbind(localiza,geoloca)
  print(i)
  
}





# Contamos datos faltantes

countNA(GeoCode[,1])

countNA(GeoCode[,1])/length(GeoCode[,1]) # tasa de datos faltantes

# Creamos un data frame con los resultados (incluyendo el nombre de cada variable [Estado])

Comparacion<-cbind(GeoCode[,1],GeoCode[,2],Gas_LP[,1])

#Guardamos un documento para tener respaldo

write.csv(Comparacion, file = "Comparacion.csv",row.names=FALSE)

#Finalmente consideraremos unicamente los valores observados de la base

Gas_LP_1<-na.omit(Comparacion)
Gas_LP_Final<-as.data.frame(cbind(Gas_LP_1[,1],Gas_LP_1[,2],Gas_LP_1[,3]))
colnames(Comp)<-c("Longitud","Latitud","Estado")

# Finalmente se presentan los resultados utilizando la libreria leaflet()

Mapa<-leaflet(Gas_LP_Final)



Mapa %>%
  addTiles() %>%  ## mapas
  addMarkers(lng=~Longitud, lat=~Latitud, popup=~Estado, clusterOptions = markerClusterOptions())



############### COLORES #######################

pal<-colorFactor(palette = rainbow(length(unique(Comp$Estado))), domain = unique(Comp$Estado), levels = NULL, ordered = FALSE, na.color = "#808080", alpha = FALSE, reverse = FALSE)

previewColors(pal,unique(Comp$Estado))

clusterOptions = markerClusterOptions()

m <- leaflet(Comp) 

m %>%
  addTiles() %>%  ## mapas
  addCircles(lng=~Longitud, lat=~Latitud, popup=~Estado,color=~pal(Comp$Estado))















