# ---
# title: "Exercice 2 -  module 7"
# ---  
# Le but de cet exercice va être d'exploiter les données *DVF* sur les transactions immobilières dans l'ancien et la carte des quartiers de Nantes pour obtenir des indicateurs des transactions par quartier.  
# On va utiliser pour DVF l'API mise en place par Christian Quest : http://api.cquest.org/dvf
# ```r
# ## Activation des packages
# library(httr)
# library(jsonlite)
# library(sf)
# library(tidyverse)
# get_dvf <- GET("http://api.cquest.org/dvf?code_commune=44109")
# dvf_content <- content(get_dvf, "text", encoding = "UTF-8")
# dvf_json <- fromJSON(dvf_content)$resultats %>%
#   # On ne garde que les données avec une géolocalisation valide, un prix et une surface renseignés.
#   filter(!is.na(lon), !is.na(lat), !is.na(valeur_fonciere), !is.na(surface_relle_bati))
# dvf <- st_as_sf(dvf_json, coords = c("lon", "lat"), crs = 4326)
# ```


# - Contour des quartiers de Nantes, ils proviennent de Nantes Métropole Open Data :https://data.nantesmetropole.fr
# ```r
# quartier_nantes <- st_read("https://data.nantesmetropole.fr/explore/dataset/244400404_quartiers-communes-nantes-metropole/download/?format=geojson&disjunctive.libcom=true&refine.libcom=Nantes&timezone=Europe/Berlin&lang=fr")
# ```


# On veut produire les infos suivantes par quartier et année :  
# - Volume de ventes (nb)   
# - Pourcentage de maisons dans les ventes  
# - Prix moyen au m2 par type de bien  
# ## Datapréparation
# ### Jointure spatiale pour récupérer les ventes par quartiers

# ### Calculs
# Calcul par quartier et année de la transaction du nombre de ventes, de leur montant et surface total par type de bien et tout bien confondu

# Calcul des indicateurs demandés

