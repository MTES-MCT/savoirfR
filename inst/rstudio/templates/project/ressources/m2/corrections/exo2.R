# ---
# title: "Exercice 2 -  module 2"
# ---  
# Convertir les colonnes de la table `exercice` au format date (quand c'est pertinent). La table `exercice` est issue de `FormationPreparationDesDonnees.RData`.
library(tidyverse)
library(lubridate)
load(file = "extdata/FormationPreparationDesDonnees.RData")




exercice1 <- mutate(exercice,
  date_prelevement = ymd(date_prelevement),
  date_creation = ymd(date_creation),
  date_formatee = format(date_prelevement, "%d/%m/%Y")) # plus joli, mais en texte 

glimpse(exercice1)


