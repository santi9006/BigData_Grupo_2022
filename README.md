# BigData_Grupo_2022

 Clase de Big Data - Actividades Grupales

## Problem Set 1

Este Readme contiene la lista de instrucciones para replicar el Problem Set. El repositorio cuenta con una carpeta llamada PS1, dentro de esta carpeta se encuentran cuatro carpetas; document, scripts, stores y views.Dentro de la carpeta PS1 la carpeta scripts contiene 2 archivos. "Data.R" y "P2_P3.R". El primer script detalla el código que nos permitió realizar el web-scraping y el procesamiento de los datos. El segundo script desarrolla el punto 2 y 3 del Problem Set.

### Data  Scraping

A continuación se describe el paso a paso para realizar el Web Scraping.Cancel changes

Primero, instalamos los siguientes paquetes.

install.packages("pacman")
install.packages("tidyverse")
install.packages("fabricatr")
install.packages("stargazer")

Tydyverse contiene una librería llamada rvest, este nos permitirá realizar el ejercicio de scrapping.

Segundo, cargamos los paquetes.

p_load(tidyverse,
       rvest,
       here,
       jtools, ## summ function
       ggstance, ## 
       broom, ## tidy function (Saca tabla lindas)
       broom.mixed, ##
       skimr,
       expss,
       dplyr,
       vtable,
       gtsummary) 
       
Tercero detallaremos el proceso de scraping en cuestión.

La base se encuentra alojada con 10 chunks. Por lo tanto definiremos una URL1 para cada uno de los archivos. Cabe resaltar que se debe se debe utilizar a Mozilla como Navegador, ya que en Chrome hay un alto consumo de memoria y el proceso para cargar los datos falla.

Una vez cargamos la base de datos inspeccionamos el código html de la página, cabe resaltar que el website tiene una máscara, por lo tanto, nos dirigimos a Red y detenemos los procesos, y encontramos un archivo tipo HTML llamado “geih_page_1.html” con un peso cercano a las 22 megas. Luego, copiamos la URL de este archivo. Una vez realizado este proceso lo replicaremos para los 9 chunks restantes, y definiremos un objeto para cada URL, para efectos prácticos lo denotamos como base con el número correspondiente a cada uno de los 10 chunks.

Luego, definimos un objeto b1 y le asignaremos el objeto read, empleando el operador “pipe” contatenando el proceso de scrapping  con la función html_nodes, está usara un xpath, o un camino que le indica a R lo que debe buscar y extraer, para encontrar este xpath recordemos la URL que denotamos para uno de los 10 chunks. Simplemente volvemos a inspeccionar la tabla y encontramos que el xpath que le indica a R lo que debe extraer tiene la siguiente “dirección” (/html), luego volvemos a utilizar el operador “pipe” indicándole a R que extraiga los datos como una estructura de tabla en html. Finalmente, el proceso  a continuación es asignarle un data frame a cada uno de estos b#; cada b# contiene un chunk de la base de datos con el proceso detallado. anteriormente.

Finalmente para cada data frame asignamos una nueva variable que indica que cada observación corresponderá a su respectivo chunk. Para ver el código completo que contiene el proceso de scraping ver el script (Data.R)
