#### Exercice 2 (chap 5.5.3)
#  Convertir les colonnes de la table exercice au format date (quand c'est pertinent).

rm(list = ls())
load(file = "extdata/FormationPreparationDesDonnees.RData")
library(tidyverse)
library(lubridate)

exercice1 <- mutate(exercice,
  date_prelevement = ymd(date_prelevement),
  date_creation = ymd(date_creation),
  date_formatee = format(date_prelevement, "%d/%m/%Y")) # plus joli, mais en texte
