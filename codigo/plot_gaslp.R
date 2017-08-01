library(leaflet)
library(RColorBrewer)
#leer datos
geo_merge <- read_excel("datos/geo_merge.xlsx")
#omitir blancos
geo_merge_l<-na.omit(geo_merge)

loca<- geo_merge_l[143:1210,]
m<-leaflet(data = loca)
#Definición de colores por Marca Comercial
colores<-loca$Marca

s<-addTiles(m)
#paleta de colores
pal<-colorFactor(palette = rainbow(length(unique(colores))),
                 domain = unique(colores), 
                 levels = NULL, 
                 ordered = FALSE, 
                 na.color = "#808080", 
                 alpha = FALSE, 
                 reverse = FALSE)

#Definicion del mapa
p<-addCircles(s,loca$longitud,loca$latitud, popup = c(loca$Razon_social), color=pal(colores))
#ploteo del mapa
p
