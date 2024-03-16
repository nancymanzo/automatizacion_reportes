# MeetUp: Automatización de reportes con R Markdown
En este evento pondremos en práctica la creación de las fichas municipales que reporta la Secretaría de Igualdad Sustantiva entre Mujeres y Hombres (SISEMH) del Estado de Jalisco, en su portal de datos abiertos de "Código Violeta" (https://igualdad.jalisco.gob.mx/acciones/datos-abiertos-codigo-violeta/)

Crearemos 125 fichas municipales en menos de 10 minutos con visualizaciones y texto que se ajusta de manera automática, haciendo uso de los datos del SESNSP.

## **Requisitos:**
### 1. Base de datos del SESNSP
Cifras de Incidencia Delictiva Municipal, 2015 - enero 2024  (https://drive.google.com/file/d/17nHQymeh3QDKbRlD_3zp-GcJ6S5jtnrA/view?usp=sharing)
### 2. Descargar los archivos de este repositorio:
   * **Plantilla** (documento word "_plantilla_ficha_municipal.docx_"): Esta funciona como plantilla de estilo como se usa con los style en HTML.
   * **RMD** ("_fichas_municipales_2024.Rmd_"): Es la ficha municipal con visualizaciones y textos.
   * **Bucle de las fichas** ("_bucle_fichas_mun.R_"): Scritp para ejecutar la función/bucle/ciclo que reproduce las 125 fichas municipales.
   * **Lista de municipios** ("_mun_jal.xlsx_"): Municipios de Jalisco
  
### En tu cónsola de R es necesario tener activadas e instaladas las siguientes paqueterías:

```
librerias <- c("dplyr", "tidyr", "lubridate", "readxl", "ggplot2", "scales",
               "stringr", "gt", "sysfonts", "showtext")

librerias_instaladas <- librerias %in% rownames(installed.packages())

if (any(librerias_instaladas == FALSE)) {
  install.packages(librerias[!librerias_instaladas])
}

invisible(lapply(librerias, library, character.only = TRUE))
```


