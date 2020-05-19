# Exercice 5 (chap 6)
# 
# - reconstituer le dataframe "exercice" à partir des données contenues dans les tables "analyse", "prelevement" et "station" (jointures)  
# 
rm(list = ls())
library(tidyverse)
library(lubridate)
load(file = "extdata/FormationPreparationDesDonnees.RData")

exercice_recalcul <- 

  
  
# - calculer le nombre d’analyses réalisées sur des molécules (code_parametre) présentes dans le référentiel `parametre`  
# 
nb_analyses_presentes_dans_referentiel  <- 
  
  
# - produire une liste des **code_parametre** associés à des analyses mais absents du référentiel  
# 
list_mol_hors_ref <- 
  
  


# - produire une table des analyses "orphelines", c'est-à-dire qui ne correspondent pas à un prélèvement  
#
analyses_orphelines <- 
  


