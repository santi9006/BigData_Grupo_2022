
## instalar/llamar pacman

install.packages("pacman")
require(pacman)
p_load(tidyverse,rvest)

## Tutorial de rvest
vignette("rvest")

#### Vamos a buscar el servidor que tiene la página

### Chunk N.1

url = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_1.html"

base = read_html(url)

b1<-  base %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b1)

view(b1)

### Chunk N.2

url2 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_2.html"

base2 = read_html(url2)
                 
b2<-  base2 %>% html_nodes(xpath = '/html')  %>%
  html_table()
  
as_tibble(b2)

view(b2)

### Chunk N.3

url3 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_3.html"

base3 = read_html(url3)

b3<-  base3 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b3)

view(b3)

### Chunk N.4

url4 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_4.html"

base4 = read_html(url4)

b4<-  base4 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b4)

view(b4)

### Chunk N.5

url5 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_5.html"

base5 = read_html(url5)

b5<-  base5 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b5)

view(b5)


### Chunk N.7

url6 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_6.html"

base6 = read_html(url6)

b6<-  base6 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b6)

view(b6)


### Chunk N.7

url7 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_7.html"

base7 = read_html(url7)

b7<-  base7 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b7)

view(b7)


### Chunk N.8

url8 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_8.html"

base8 = read_html(url8)

b8<-  base8 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b8)

view(b8)


### Chunk N.9

url9 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_9.html"

base9 = read_html(url9)

b9<-  base9 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b9)

view(b9)


### Chunk N10

url10 = "https://ignaciomsarmiento.github.io/GEIH2018_sample/pages/geih_page_10.html"

base10 = read_html(url10)

b10<-  base10 %>% html_nodes(xpath = '/html')  %>%
  html_table()

as_tibble(b10)

view(b10)


install.packages("pandas")

require(pandas)
