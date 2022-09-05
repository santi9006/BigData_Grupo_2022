###############################################################
################ Big Data and Machine Learning ################
###############################################################


## A continuación se describe el paso a paso para realizar el Web Scraping.

## 1. Instalar/Cargar Paquetes
 
install.packages("pacman")
install.packages("tidyverse")
install.packages("fabricatr")
install.packages("stargazer")

require("pacman")
require("tidyverse")
require("fabricatr")
require("stargazer")

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

## 2. Para cada chunk, buscamos la URL, hacemos el scrapping y definimos la base "Master"

### 2.1 Definir las URL para cada chunk

url = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_1.html"
url2 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_2.html"
url3 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_3.html"
url4 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_4.html"
url5 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_5.html"
url6 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_6.html"
url7 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_7.html"
url8 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_8.html"
url9 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_9.html"
url10 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_10.html"

### 2.2 Definir un tibble para cada chunk

base1 = read_html(url)
b1<-  base1 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b1<-as.data.frame(b1)
b1$chunk<- 1

base2 = read_html(url2)
b2<-  base2 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b2<-as.data.frame(b2)
b2$chunk<- 2


base3 = read_html(url3)
b3<-  base3 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b3<-as.data.frame(b3)
b3$chunk<- 3

base4 = read_html(url4)
b4<-  base4 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b4<-as.data.frame(b4)
b4$chunk<- 4

base5 = read_html(url5)
b5<-  base5 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b5<-as.data.frame(b5)
b5$chunk<- 5

base6 = read_html(url6)
b6<-  base6 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b6<-as.data.frame(b6)
b6$chunk<- 6

base7 = read_html(url7)
b7<-  base7 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b7<-as.data.frame(b7)
b7$chunk<- 7

base8 = read_html(url8)
b8<-  base8 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b8<-as.data.frame(b8)
b8$chunk<- 8

base9 = read_html(url9)
b9<-  base9 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b9<-as.data.frame(b9)
b9$chunk<- 9

base10 = read_html(url10)
b10<-  base10 %>% html_nodes(xpath = '/html')  %>%
  html_table()
b10<-as.data.frame(b10)
b10$chunk<- 10

### 2.2 Hacer un append y definir la base Master
master<-rbind.data.frame(b1, b2, b3, b4, b5, b6, b7, b8, b9, b10)

## 3. Creamos la base ps1, que ya esta limpia y solo tiene la informacion que se necesitamos en el Problem Set

### 3.1 Dejamos solo a los mayores de 18 a??os y que estan trabajando*
###### Nota La variable P6240 pregunta en que actividad ocupo la mayor parte del tiempo la semana pasada, y =1 significa "Trabajando"

ps1<- subset(master, age>17 & p6240==1)
ps1$ingtotha <- ps1$ingtot/ (4*ps1$hoursWorkUsual)  ##Creo una variable de ingtotal por hora

### 3.2 Dejamos solo las variables de inter??s, y les ponemos labels*

ps1_trim = ps1 %>% 
  select(age, sex, ingtot, ingtotha, y_total_m, y_total_m_ha, estrato1, informal,maxEducLevel,microEmpresa, oficio, p6426, chunk)

ps1_trim$maxEducLevel[ps1_trim$maxEducLevel==7] <- NA
ps1_trim$age2<-(ps1_trim$age)^2

ps1_trim = apply_labels(ps1_trim, 
                        age ="Edad en Anos",
                        age2 ="Edad en Anos al cuadrado",
                        sex ="Sexo",
                        sex =c("Hombre"=1, "Mujer"=0),
                        ingtot ="Ingreso Total mensual",
                        ingtotha ="Ingreso Total por hora",
                        y_total_m ="Ingreso Total mensual",
                        y_total_m_ha ="Ingreso Total por hora",
                        estrato1 ="Estrato 1-6",
                        informal ="Informalidad",
                        informal =c("Informal"=1, "Formal"=0),
                        maxEducLevel ="Maximo Nivel educativo",
                        maxEducLevel =c("Ninguno"=1, "Preescolar"=2, "Primaria 1-5"=3, "Secundaria 6-9"=4, "Media 10-13"=5, "Universitaria"=6),
                        microEmpresa="Microempresa=1",
                        microEmpresa =c("Microempresa"=1, "No Microempresa"=0),
                        oficio ="Codigo de Oficio",
                        p6426="Antiguedad en meses en el oficio",
                        chunk="N??mero de Chunk del que proviene la observacion")
                  
### 3.3 Guardamos la base limpia en la carpeta stores

setwd("Utilice su directorio de preferencia")


## 4. Hacemos las estad??sticas descriptivas

st(ps1_trim, vars=c('age', 'age2', 'ingtot', 'ingtotha', 'y_total_m', 'y_total_m_ha', 'estrato1','p6426'), 
   labels=c('Edad', 'Edad^2', 'Ingreso Total Mensual (Pesos, Medida 1)',
            'Ingreso Total Hora (Pesos, Medida 1)', 
            'Ingreso Total Mensual (Pesos, Medida 2)', 
            'Ingreso Total Hora (Pesos, Medida 2)', 
            'Estrato - 1 a 6',
            'Antiguedad (meses)'), summ.names = list(c('Observaciones','Promedio','Desv.Est.','Min','Max')))
                        
tab_categoricas <- ps1_trim %>% select(sex, informal, maxEducLevel, microEmpresa) %>% tbl_summary(type = list(sex ~ "categorical", informal~ "categorical", microEmpresa~ "categorical"), missing="no")
tab_categoricas
                        
