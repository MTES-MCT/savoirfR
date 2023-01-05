# ---
# title: "Exercice 3 -  module 7"
# ---  
# Avec les résultats de l'exercice 2, produire les cartes du nombre de ventes et du prix au m2 des maisons en 2019 par quartier de Nantes.
library(tidyverse)
library(gouvdown)
ggplot() +
  geom_sf(
    data = indicateurs %>%
      filter(annee_mutation == 2019),
    aes(fill = nb_ventes)
  ) + 
  theme_gouv_map() +
  scale_fill_gouv_continuous()

ggplot() +
  geom_sf(
    data = indicateurs %>%
      filter(annee_mutation == 2019),
    aes(fill = prix_m2_maison)
  ) + 
  theme_gouv_map() +
  scale_fill_gouv_continuous()

