# Exercice 1 : Les données mensuelles sitadel (chap 5.5.2)
#
# À partir du fichier sitadel de février 2017 (ROES_201702.xls), produire un dataframe 'sit_pdl_ind' contenant
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


#### solution sans le pipe %>%
sit_52_ind <- filter(sitadel, REG == "52")
sit_52_ind <- arrange(sit_52_ind, date)
sit_52_ind <- mutate(sit_52_ind,
  i_AUT = ip_AUT + ig_AUT,
  i_AUT_cum12 = roll_sumr(i_AUT, 12),
  i_AUT_cum12_lag12 = lag(i_AUT_cum12, 12),
  i_AUT_cum_evo = (i_AUT_cum12 - i_AUT_cum12_lag12) / i_AUT_cum12_lag12 * 100,
  log_AUT_cum12 = roll_sumr(log_AUT, 12),
  part_i_AU = i_AUT_cum12 / log_AUT_cum12 * 100)


#### solution avec le pipe %>%
sit_52_ind <- sitadel %>%
  filter(REG == "52") %>%
  arrange(date) %>% # pour être certain de l'ordre des lignes
  mutate(i_AUT = ip_AUT + ig_AUT,
    i_AUT_cum12 = roll_sumr(i_AUT, 12),
    i_AUT_cum12_lag12 = lag(i_AUT_cum12, 12), # création d'une colonne intermédiaire qui décale les valeurs de 12 mois pour mettre côte à côte les cumul d'autorisations espacés de 12 mois
    i_AUT_cum_evo = (i_AUT_cum12 - i_AUT_cum12_lag12) / i_AUT_cum12_lag12 * 100,
    log_AUT_cum12 = roll_sumr(log_AUT, 12), # création d'une colonne intermédiaire pour calculer le cumul de logements autorisés les 12 derniers mois
    part_i_AU = i_AUT_cum12 / log_AUT_cum12 * 100
  )
