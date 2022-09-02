###################### Cargar paquetes y base de datos##################

rm(list =ls())

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
       gtsummary,
       interactions) 

setwd("/Users/SantyDLC/Dropbox (Personal)/Doctorado Uniandes/202220/Machine Learning/GitHub/BigData_Grupo_2022/PS1/stores")
load("ps1_trim.Rda")

#################### Punto 2#####################

## 2.1. Regresion 
m1<-lm(y_total_m_ha~age+c(age*age), ps1_trim)

## 2.2. Plot 
effect_plot(model=m1, pred = age, interval=TRUE)


#################### Punto 3#####################

#Se crea la variable female y log income:#

ps1_trim$female<-ifelse(ps1_trim$sex==0,1,0)
ps1_trim$logincome<-log(ps1_trim$y_total_m_ha)
ps1_trim$maxEducLevel<-factor(ps1_trim$maxEducLevel)
ps1_trim$oficio<-factor(ps1_trim$oficio)


## 3.1. Regresion y plot

m2<-lm(logincome~female, ps1_trim)
m3<-lm(logincome~female+age+c(age*age)+female*age+female*c(age*age), ps1_trim)
interact_plot(model=m3, pred = age, modx=female, interval=TRUE)

## 3.2. Earnings gender gap

## Paso 1 - Estimo el modelo para predecir el ingreso de cada sexo
m4<- lm(logincome~female+age+c(age*age)+female*age+female*c(age*age)+estrato1+informal+maxEducLevel+microEmpresa+p6426+estrato1*female+informal*female+maxEducLevel*female+microEmpresa*female+p6426*female, ps1_trim)
summary(m4)
interact_plot(model=m4, pred = age, modx=female, interval=TRUE)

## Paso 2 - Estimo el ingreso predicho de cada sexo y la diferencia es el gap promedio

ps1_trim_men<-ps1_trim
ps1_trim_men$female<-0
logincome_men<-predict(m4,newdata=ps1_trim_men)
income_men<-exp(logincome_men)

ps1_trim_women<-ps1_trim
ps1_trim_women$female<-1
logincome_women<-predict(m4,newdata=ps1_trim_men)
income_women<-exp(logincome_women)

gender_gap=income_men-income_women
summary(gender_gap)







