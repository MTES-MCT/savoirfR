# Exercice 1 : Les données mensuelles sitadel (chap 5.5.2)
# 
# À partir du fichier sitadel de février 2017 (ROES_201702.xls), produire un dataframe 'sit_52_ind' contenant
# pour la région Pays-de-la-Loire (code région 52),
# pour chaque mois et
# pour les logements individuels (definis par la somme des logements individuels purs et individuels groupés : i_AUT = ip_AUT + ig_AUT) :
#    - le cumul des autorisations sur 12 mois glissants (i_AUT_cum12)
#    - le taux d’évolution du cumul sur 12 mois (i_AUT_cum_evo, en %)
#    - la part de ce cumul dans celui de l’ensemble des logements autorisés (log_AUT), en pourcentage

rm(list = ls())
library(tidyverse)
library(readxl)
library(RcppRoll)


sitadel <- read_excel("extdata/ROES_201702.xls",
                      sheet = "AUT_REG",
                      col_types = c("text", "text", "numeric", "numeric", "numeric", "numeric")
                      )


sit_52_ind <- 