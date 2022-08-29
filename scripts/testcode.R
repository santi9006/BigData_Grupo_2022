# Clean the workspace
rm(list=ls())
cat("\014")
local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org";options(repos=r)}) #set repo

require(tidyverse)
require(gtsummary)

dta<-readRDS("file.Rds")

#Voy a agregar estadísticas descriptivas

gtsummary(data(name))