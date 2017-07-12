install.packages("ggmap")

library(ggmap)

gas<-gas_geoloca

localiza<-data.frame()

for(i in 1001:2420){
      dir<-paste0(gas$Estado[i]," , ",gas$Municipio[i]," , ",gas$Dirección[i])
      dire<-geocode(dir)
      geoloca<-data.frame( Permiso=gas$`No. Permiso`[i], Estado=gas$Estado[i], Municipio=gas$Municipio[i], Dir=gas$Dirección[i],latitud=dire$lat,longitud=dire$lon)
      localiza<-rbind(localiza,geoloca)
      print(i)
      
}

write.csv(localiza,"D:/Users/aruiz/Documents/Gas/localiza_gas.csv")
