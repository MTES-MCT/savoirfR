# Exercice 3 (chap 5.10)
# 
# A partir des données “sitadel” chargées dans l'exercice 1, effectuer les opérations suivantes en utilisant l’opérateur %>% :
#   - effectuer les mêmes calculs que ceux réalisés sur la région 52, mais sur chacune des régions --> à stocker dans 'sit_ind'
#   - calculer les aggrégations par année civile pour chacune des régions, puis leur taux d’évolution d’une année sur l’autre 
#     (exemple : (val2015-val2014)/val2014) --> à stocker dans 'sit_annuel'
# 

rm(list = ls())
library(tidyverse)
library(readxl)
library(RcppRoll)

sitadel <- read_excel("extdata/ROES_201702.xls",
                      sheet = "AUT_REG",
                      col_types = c("text", "text", "numeric", "numeric", "numeric", "numeric")
)

sit_ind <- 

sit_annuel <- 
  
  
  
  