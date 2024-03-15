
# Librerías  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

library(dplyr)
library(tidyr)
library(lubridate)
library(readxl)

# Listado de los municipios a partir de una base de datos - - - - - - - - - - - - - - - -

mun_jal <- read_excel("C:/Users/manzo/OneDrive/Documentos/NLMR/mun_jal.xlsx", sheet = "Sheet 1")
municipios <- mun_jal %>% select(Municipio) %>% pull()

# Base de datos del SESNSP - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

datos_jalisco<-read.csv("C:/Users/manzo/OneDrive/Documentos/Justicia/SESNSP/IDM_NM_ene24.csv",check.names = T, encoding = "latin1") %>%
  filter(Entidad=="Jalisco",
         Subtipo.de.delito %in% c("Violencia familiar", "Feminicidio")) %>% 
  gather(Mes, Carpetas, Enero:Diciembre) %>% 
  group_by(Año, Mes, Subtipo.de.delito, Municipio) %>% 
  summarise(value=sum(Carpetas, na.rm = T)) %>% 
  mutate(date=ymd(paste0(Año, "-", Mes, "-01")))


# Creación de un mes y año, para automarizar los textos de las fichas - - - - - - - 

año <- datos_jalisco %>% 
  group_by(fecha=floor_date(date, "month")) %>% 
  summarise(Total=sum(value, na.rm = T)) %>%
  filter(Total>0) %>% 
  pull(fecha) %>% 
  max() %>% 
  year()


mes <- datos_jalisco %>% 
  group_by(fecha=floor_date(date, "month")) %>% 
  summarise(Total=sum(value, na.rm = T)) %>%
  filter(Total>0) %>% 
  pull(fecha) %>% 
  max() %>% 
  lubridate::month(abbr = F, label = T)


# año <-2024 
# mes <-"Enero" 


# Función para ejecutar las fichas automatizadas - - - - - - - - - - - - - - - - - - - - - - -

for(i in municipios){
  
  rmarkdown::render(input = "fichas_municipales_2024.Rmd", #archivo RMD de la ficha
                    output_file = paste0("Fichas/Ficha_Municipal_enero_", i, ".doc"), #carpeta dónde se guarda
                    params = list(params_mun = i) #parametro que ayuda a identificar y filtar por cada municipios
                    )
}
