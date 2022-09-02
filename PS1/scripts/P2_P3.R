###################### Cargar paquetes y base de datos##################

rm(list =ls())

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
       gtsummary,
       interactions) 

setwd("/Users/SantyDLC/Dropbox (Personal)/Doctorado Uniandes/202220/Machine Learning/GitHub/BigData_Grupo_2022/PS1/stores")
load("ps1_trim.Rda")

#################### Punto 2#####################

## 2.1. Regresion 
m1<-lm(y_total_m_ha~age+c(age*age), ps1_trim)
stargazer(m1,type="text")

## 2.2. Plot 
effect_plot(model=m1, pred = age, interval=TRUE)


#################### Punto 3#####################

#Se crea la variable female y log income, y se vuelven factor la de educaci??n#

ps1_trim$female<-ifelse(ps1_trim$sex==0,1,0)
ps1_trim$logincome<-log(ps1_trim$y_total_m_ha)
ps1_trim$maxEducLevel<-factor(ps1_trim$maxEducLevel)


## 3.1. Regresion y plot

m2<-lm(logincome~female, ps1_trim)
stargazer(m2,type="text")

m3<-lm(logincome~female+age+c(age*age)+female*age+female*c(age*age), ps1_trim)
interact_plot(model=m3, pred = age, modx=female, interval=TRUE)
stargazer(m3,type="text")

## 3.2. Earnings gender gap

## Paso 1 - Estimo el modelo para predecir el ingreso de cada sexo
m4<- lm(logincome~female+age+c(age*age)+female*age+female*c(age*age)+estrato1+informal+maxEducLevel+microEmpresa+p6426+estrato1*female+informal*female+maxEducLevel*female+microEmpresa*female+p6426*female, ps1_trim)
summary(m4)
interact_plot(model=m4, pred = age, modx=female, interval=TRUE)
stargazer(m4,type="text")


## Paso 2 - Estimo el ingreso predicho de cada sexo y la diferencia es el gap promedio

ps1_trim_men<-ps1_trim
ps1_trim_men$female<-0
logincome_men<-predict(m4,newdata=ps1_trim_men)
income_men<-exp(logincome_men)

ps1_trim_women<-ps1_trim
ps1_trim_women$female<-1
logincome_women<-predict(m4,newdata=ps1_trim_women)
income_women<-exp(logincome_women)

gender_gap_pesos=income_men-income_women
gender_gap_porcentaje=((exp(logincome_men-logincome_women))*100)-100

summary(gender_gap_pesos)
summary(gender_gap_porcentaje)
##Se observa que las hombres ganan en promedio 625 pesos m??s por hora, o 17.98& m??s por hora que las mujeres" 

## Paso 3 - Estimo la regresi??n del modelo 4 por FWL ##

##Compa??eros, no s?? c??mo lidiar con las interacciones aqu??, entonces logr?? hacer hasta aqu??#
m4<- lm(logincome~female+age+c(age*age)+female*age+female*c(age*age)+estrato1+informal+maxEducLevel+microEmpresa+p6426+estrato1*female+informal*female+maxEducLevel*female+microEmpresa*female+p6426*female, ps1_trim)
summary(m4)

db<-ps1_trim %>% mutate(res_y_all=lm(logincome~age+c(age*age)+estrato1+informal+maxEducLevel+microEmpresa+p6426+estrato1*female+informal*female+maxEducLevel*female+microEmpresa*female+p6426*female, ps1_trim)$residuals, #Residuales de ingreso contra todo menos female
                  res_female_todo=lm(female~##No tengo idea qu?? poner aqu??#)$residuals, #Residuales de female contra todo menos female
                                       )

m5<-lm(res_y_all~res_female_todo-1,db)
stargazer(m4,m5,type="text")










