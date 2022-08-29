# Clean the workspace
rm(list=ls())
cat("\014")
local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org";options(repos=r)}) #set repo

require(tidyverse)

dta<-readRDS("file.Rds")