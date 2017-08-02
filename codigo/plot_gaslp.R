library(leaflet)
library(RColorBrewer)
library(readxl)
#leer datos
geo_merge <- read_excel("datos/geo_merge.xlsx")

#omitir blancos
geo_merge_l<-na.omit(geo_merge)

loca<- geo_merge_l
#Definici?n de colores por Marca Comercial
colores<-loca$GRUPO

pal<-colorFactor(palette = rainbow(length(unique(colores))),
      domain = unique(colores), 
      levels = NULL, 
      ordered = FALSE, 
      na.color = "#808080", 
      alpha = FALSE, 
      reverse = FALSE)

#ploteo del mapa

m<-leaflet(data = loca) %>%
      addTiles() %>%
      addCircles(~longitud,~latitud, popup = ~RZ, color=pal(colores))

m
