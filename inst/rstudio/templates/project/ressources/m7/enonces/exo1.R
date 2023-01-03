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

# ### Récupération de la carte des quartiers
# Résultat intermédiaire :

# ## Datapréparation
# ### Jointure spatiale pour récupérer les ventes par quartiers

# ### Calculs
# Calcul par quartier et année de la transaction du nombre de ventes, de leur montant et surface total par type de bien et tout bien confondu

# Calcul des indicateurs demandés 
# Résultat intermédiaire : 

# ## Datavisualisation
# Carte du nombre de ventes en 2018

# Carte du prix au m²  en 2018

