# Exercice 5 (chap 6)
# 
# - reconstituer le dataframe "exercice" à partir des données contenues dans les tables "analyse", "prelevement" et "station" (jointures)  
# 
rm(list = ls())
library(tidyverse)
library(lubridate)
load(file = "extdata/FormationPreparationDesDonnees.RData")

exercice_recalcul <- analyse %>%
  inner_join(prelevement, by="code_prelevement") %>%
  inner_join(station, by="code_station") %>%
  mutate (date_creation = as.character(date_creation),
          annee = year(date_prelevement))


# - calculer le nombre d’analyses réalisées sur des molécules (code_parametre) présentes dans le référentiel `parametre`  
# 
nb_analyses_presentes_dans_referentiel  <- analyse %>% 
  inner_join(parametre, by = "code_parametre") %>% 
  select(code_analyse) %>%
  n_distinct()

# - produire une liste des **code_parametre** associés à des analyses mais absents du référentiel  
# 
list_mol_hors_ref <- analyse %>% 
  anti_join(parametre, by="code_parametre") %>%
  select(code_parametre) %>%
  distinct() %>%
  pull(code_parametre)

# ou
list_mol_hors_ref2 <- analyse %>% 
  filter(!(code_parametre %in% parametre$code_parametre)) %>%
  select(code_parametre) %>%
  distinct() %>%
  pull(code_parametre)


# - produire une table des analyses "orphelines", c'est-à-dire qui ne correspondent pas à un prélèvement  
#
analyses_orphelines <- analyse %>%
  anti_join(prelevement, by=c("code_prelevement"))



