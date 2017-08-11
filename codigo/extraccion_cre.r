#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################

library(tidyverse)
library(httr)
library(jsonlite)

#creacion del data frame
tabla_cre<-data.frame()
autotanques <- data.frame()
recipientes <- data.frame()

#Tabla de datos de municipios
N_est<-c(1:32)
N_mun<-c(11,5,5,11,122,67,16,38,10,39,46,81,84,125,125,113,33,20,51,570,217,18,11,58,18,72,17,43,60,212,106,58)

rela<-data.frame(Estado=N_est,Municipio=N_mun)

#Primer bucle de extracci?n por estado

for(j in 1:32){
      
      # j <- 1
  
#Segundo bucle de extraccion por municipio

    for(k in 1:rela$Municipio[j]){

      # k <- 1
        
        mun<-as.character(1000+k)
        muni<-substr(mun,2,4)
        est<-as.character(100+j)
        esta<-substr(est,2,3)
        
        
        Sys.sleep(60*2)
        
        repos <- GET(url = paste0("http://api-reportediario.cre.gob.mx/api/PlantaDistribucion/precio?localidadId=null&entidadId=",esta,"&municipioId=",muni))
      
      #  status_code(repos)
       
         repo_content <- content(repos)
        
        
        repo_df <- lapply(repo_content$AutoTanques, function(x) {
              df <- data_frame(
                    RazonSocial             = x$RazonSocial,
                    NumeroPermiso           = x$NumeroPermiso,
                    EntidadFederativaId     = x$EntidadFederativaId,
                    MunicipioId             = x$MunicipioId,
                    LocalidadId             = x$LocalidadId,
                    EsPermisionario         = x$EsPermisionario,
                    MedioId               = x$MedioId,
                    PrecioId              = x$PrecioId,
                    Precio                = x$Precio,
                    FechaAplicacion       = x$FechaAplicacion,
                    Activo                = x$Activo,
                    Direccion             = x$Direccion,
                    EntidadFederativa     = x$EntidadFederativa,
                    Municipio             = x$Municipio,
                    Localidad             = x$Localidad)
        }) %>% bind_rows()
        
        autotanques <- rbind(autotanques,repo_df)
        
        repo_df <- lapply(repo_content$Recipientes, function(x) {
              df <- data_frame(
                    RazonSocial             = x$RazonSocial,
                    NumeroPermiso           = x$NumeroPermiso,
                    EntidadFederativaId     = x$EntidadFederativaId,
                    MunicipioId             = x$MunicipioId,
                    LocalidadId             = x$LocalidadId,
                    EsPermisionario         = x$EsPermisionario,
                    MedioId               = x$MedioId,
                    PrecioId              = x$PrecioId,
                    CapacidadRecipiente   = x$CapacidadRecipiente, 
                    Precio                = x$Precio,
                    FechaAplicacion       = x$FechaAplicacion,
                    Activo                = x$Activo,
                    Direccion             = x$Direccion,
                    EntidadFederativa     = x$EntidadFederativa,
                    Municipio             = x$Municipio,
                    Localidad             = x$Localidad)
        }) %>% bind_rows()
        
        
        recipientes <- rbind(recipientes,repo_df)
        
        
}
}


