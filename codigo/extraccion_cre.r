#Garga de librería
library(XML)
#creacion del data frame
tabla_cre<-data.frame()
#Tabla de datos de municipios
N_est<-c(1:32)
N_mun<-c(11,	5,	5,	11,	122,	67,	16,	38,	10,	39,	46,	81,	84,	125,	125,	113,	33,	20,	51,	570,	217,	18,	11,	58,	18,	72,	17,	43,	60,	212,	106,	58)
rela<-data.frame(Estado=N_est,Municipio=N_mun)
#Primer bucle de extracción por estado
for(j in 1:1){
  #Segundo bucle de extraccion por municipio
    for(k in 11:rela$Municipio[j]){
        mun<-as.character(1000+k)
        muni<-substr(mun,2,4)
        est<-as.character(100+j)
        esta<-substr(est,2,3)
        cre<-read_html(paste0("http://api-reportediario.cre.gob.mx/api/PlantaDistribucion/precio?localidadId=null&entidadId=",esta,"&municipioId=",muni))
        c<-as.character(cre)
        separa_1<-strsplit(c,":")
        separa_1
        separa_2<-strsplit(as.character(separa_1),"\"")
        separa_2
        r<-separa_2[[1]]
        #Tercer bucle, estructuración de la informacion
        for(i in 0:5000){
            cre_tb<-data.frame(Razonsocial=r[17+88*i],
                               N_permiso=r[23+88*i],
                               Estado=r[83+88*i],
                               Municipio=r[89+88*i],
                               Localidad=r[95+88*i],
                               Precio=r[56+88*i],
                               Fecha_aplica=r[61+88*i],
                               Dirección=r[75+88*i])
            tabla_cre<-rbind(tabla_cre,cre_tb)
      print(paste0("vamos en la ",i," del municipio ",k," del estado ",j))
}
}
}
#Impresion de la tabla
View(tabla_cre)

