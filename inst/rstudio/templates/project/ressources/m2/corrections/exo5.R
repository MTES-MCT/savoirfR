# ---
# title: "Exercice 5 -  module 2"
# ---  
# Dans les données `FormationPreparationDesDonnees.RData`, chaque analyse est effectuée à partir d'un prélèvement, lui-même réalisé au niveau d'une station.   
# - Reconstituer le dataframe `exercice` qui rassemble les données contenues dans les tables `analyse`, `prelevement` et `station` grâce à des jointures. Il faut partir de la table `analyse` et faire des jointures   
# - calculer le nombre d'analyses réalisées sur des molécules (identifiables par leur `code_parametre`) et décrites dans le référentiel `parametre` ;  
# - produire une liste des `code_parametre` associés à des analyses mais absents du référentiel ;  
# - produire une table des analyses "orphelines", c'est-à-dire qui ne correspondent à aucun prélèvement.  
library(tidyverse)
library(lubridate)
load(file = "extdata/FormationPreparationDesDonnees.RData")




# Recalcul table exercice
exercice_recalcul <- analyse %>%
  inner_join(prelevement, by = "code_prelevement") %>%
  inner_join(station, by = "code_station") %>%
  mutate(date_creation = as.character(date_creation),
         annee = year(date_prelevement))

exercice_recalcul %>% 
  glimpse()

# Vérification :
verif <- identical(exercice, exercice_recalcul)

# Nombre d'analyses réalisées sur des molécules (code_parametre) présentes dans le référentiel `parametre`
nb_analyses_presentes_dans_referentiel <- analyse %>%
  inner_join(parametre, by = "code_parametre") %>%
  select(code_analyse) %>%
  n_distinct()

nb_analyses_presentes_dans_referentiel

# Liste des `code_parametre` associés à des analyses mais absents du référentiel
list_mol_hors_ref <- analyse %>%
  anti_join(parametre, by = "code_parametre") %>%
  select(code_parametre) %>%
  distinct() %>%
  pull(code_parametre)

list_mol_hors_ref

# ou
list_mol_hors_ref2 <- analyse %>%
  filter(!(code_parametre %in% parametre$code_parametre)) %>%
  select(code_parametre) %>%
  distinct() %>%
  pull(code_parametre)

# Table des analyses "orphelines", c'est-à-dire ne correspondent à aucun prélèvement
analyses_orphelines <- analyse %>%
  anti_join(prelevement, by = c("code_prelevement"))

analyses_orphelines %>%
  glimpse()

