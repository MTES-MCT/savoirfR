# ---
# title: "Exercice 1 -  module 7"
# ---  
# Le but de cet exercice va être d’exploiter les données DVF sur les transactions immobilières dans l’ancien et la carte des quartiers de Nantes pour obtenir un prix moyen des transactions par quartier. On va utiliser pour DVF l’API mise en place par Christian Quest.
# - Données DVF : http://api.cquest.org/dvf (http://api.cquest.org/dvf?code_commune=44109 pour récupérer les données de Nantes)
# - Contour des quartiers de Nantes : https://data.nantesmetropole.fr/explore/dataset/244400404_quartiers-communes-nantes-metropole/download/?format=geojson&timezone=Europe/Berlin&lang=fr
# On veut produire les infos suivantes par quartier et annee :
# - Volume de ventes
# - Pourcentage de maison dans les ventes
# - Prix moyen au m2 par type de bien
#     
# ## Chargements des données
# ### DVF
# Résultat intermédiaire :
library(httr)
library(jsonlite)
library(sf)
library(tidyverse)
library(lubridate)

get_dvf <- GET("http://api.cquest.org/dvf?code_commune=44109")
dvf_content <- content(get_dvf, "text")

dvf_json <- fromJSON(dvf_content)$resultats %>%
  filter(!is.na(lon), !is.na(lat), !is.na(valeur_fonciere), !is.na(surface_relle_bati))

dvf <- st_as_sf(dvf_json,
  coords = c("lon", "lat"),
  crs = 4326
)

dvf %>%
  glimpse()

# ### Récupération de la carte des quartiers
# Résultat intermédiaire :
quartier_nantes <- st_read(dsn = "https://data.nantesmetropole.fr/explore/dataset/244400404_quartiers-communes-nantes-metropole/download/?format=geojson&timezone=Europe/Berlin&lang=fr", quiet = TRUE)

quartier_nantes %>%
  glimpse()

# ## Datapréparation
# ### Jointure spatiale pour récupérer les ventes par quartiers
dvf_avec_quartier <- st_join(
  dvf,
  quartier_nantes %>%
    select(nom)
) %>%
  rename(quartier = nom)

dvf_avec_quartier %>%
  glimpse()

# ### Calculs
# Calcul par quartier et année de la transaction du nombre de ventes, de leur montant et surface total par type de bien et tout bien confondu
stat1 <- dvf_avec_quartier %>%
  st_drop_geometry() %>%
  filter(
    nature_mutation == "Vente",
    type_local %in% c("Appartement", "Maison")
  ) %>%
  mutate(
    date_mutation = ymd(date_mutation),
    annee_mutation = year(date_mutation),
    nb_ventes = 1
  ) %>%
  group_by(quartier, type_local, annee_mutation) %>%
  summarise_at(vars(nb_ventes, valeur_fonciere, surface_relle_bati), funs(sum)) %>%
  ungroup()


stat2 <- dvf_avec_quartier %>%
  st_drop_geometry() %>%
  filter(
    nature_mutation == "Vente",
    type_local %in% c("Appartement", "Maison")
  ) %>%
  mutate(
    date_mutation = ymd(date_mutation),
    annee_mutation = year(date_mutation),
    nb_ventes = 1,
    type_local = "Ensemble"
  ) %>%
  group_by(quartier, type_local, annee_mutation) %>%
  summarise_at(vars(nb_ventes, valeur_fonciere, surface_relle_bati), funs(sum)) %>%
  ungroup()

stat <- bind_rows(stat1, stat2)

stat %>%
  glimpse()

# Calcul des indicateurs demandés 
# Résultat intermédiaire : 
indicateurs1 <- stat %>%
  filter(type_local == "Ensemble") %>%
  select(quartier, annee_mutation, nb_ventes)

indicateurs2 <- stat %>%
  select(quartier, annee_mutation, type_local, nb_ventes) %>%
  spread(type_local, nb_ventes) %>%
  mutate(pourcentage_maison = 100 * Maison / Ensemble) %>%
  select(quartier, annee_mutation, pourcentage_maison)

indicateurs3 <- stat %>%
  select(quartier, annee_mutation, type_local, valeur_fonciere, surface_relle_bati) %>%
  mutate(prix_m2 = valeur_fonciere / surface_relle_bati) %>%
  select(quartier, annee_mutation, type_local, prix_m2) %>%
  spread(type_local, prix_m2) %>%
  rename_at(vars(Appartement, Maison, Ensemble), funs(paste0("prix_m2_", .)))

indicateurs <- reduce(list(indicateurs1, indicateurs2, indicateurs3), left_join)

indicateurs <- quartier_nantes %>%
  select(quartier = nom) %>%
  left_join(indicateurs)

indicateurs %>%
  glimpse()

# ## Datavisualisation
# Carte du nombre de ventes en 2018
ggplot() +
  geom_sf(
    data = indicateurs %>%
      filter(annee_mutation == 2018),
    aes(fill = nb_ventes)
  )

# Carte du prix au m²  en 2018
ggplot() +
  geom_sf(
    data = indicateurs %>%
      filter(annee_mutation == 2018),
    aes(fill = nb_ventes)
  )

