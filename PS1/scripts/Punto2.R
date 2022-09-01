## Punto 2##

### 2.1 Cargar paquetes y base de datos#
install.packages("pacman")
require(pacman)
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

setwd("/Users/SantyDLC/Dropbox (Personal)/Doctorado Uniandes/202220/Machine Learning/GitHub/BigData_Grupo_2022/PS1/stores")
use(ps1_trim.Rda)

## 2.2. Regresi??n y gr??fica

m1<-lm(y_total_m_ha~age+c(age*age), ps1_trim)
effect_plot(model=m1, pred = age, interval=TRUE)

model.fit(ps1_trim$age, ps1_trim$y_total_m_ha)
preds = model.predict(X_train)
train_residuals = y_train - preds


