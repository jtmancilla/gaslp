GeoLocalizacion<-function(DataFrame){
  
#El Data Frame que se recibe deberá contener: Direccion, Municipio, Estado y Codigo Postal. 
  
  # Cargamos el paquete a usar
  
  colnames(DataFrame)<-c("Direccion","Municipio","Estado","CP")
  
  install.packages(ggmap)
  require(ggmap)
  
  # Creamos una matriz auxiliar para recaudar los datos de longitud y latitud

  BaseActualizada<-data.frame()
  
  for(i in 1:length(DataFrame[,1])){
    dir<-paste0(DataFrame$Estado[i]," , ",DataFrame$Municipio[i]," , ",DataFrame$Dirección[i])
    dire<-geocode(dir)
    geoloca<-data.frame(gasLP_DISTRIBUIDORES$Estado[i]," , ",gasLP_DISTRIBUIDORES$Municipio[i]," , ",gasLP_DISTRIBUIDORES$Dirección[i] ,latitud=dire$lat,longitud=dire$lon)
    BaseActualizada<-rbind(BaseActualizada,geoloca)
    print(i)
    
  }
  
  return(BaseActualizada)
  
  write.csv(BaseActualizada,file = "BaseActualizada.csv")
  
}