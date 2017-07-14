library(readxl)
library(ggmap)
#Leer permisos de gas LP
gas<-read_excel("datos/Permisos_GASLP_pdf.xlsx")

localiza<-data.frame()

for(i in 2001:3236){
      dir<-paste0(gas$Calle[i],", ",gas$Municipio[i],", ",gas$Estado[i])
      dire<-geocode(dir)
      geoloca<-data.frame( Permiso= gas$`Número de Permiso`[i],
                           Estado=gas$Estado[i], 
                           Municipio=gas$Municipio[i],
                           Marca=gas$`Marca Comercial`[i], 
                           Razon=gas$`Razón social`[i],
                           Dir=gas$Calle[i],
                           latitud=dire$lat,
                           longitud=dire$lon)
      localiza<-rbind(localiza,geoloca)
      print(i)
      
}

#Escribir el csv en la carpeta datos
write.csv(localiza,"datos/localiza_gas.csv")
