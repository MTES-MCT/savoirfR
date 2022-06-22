# Exercice : calcul de statistiques

# Nous allons travailler sur des indicateurs au territoire extrait de l'outil geoidd du ministère et exporté en csv
# avec les variables que nous avons calculées à l'exercice précédent

df <- read.csv(file = "extdata/Base_synth_territoires.csv", header = TRUE, sep = ";", dec = ",",
               colClasses = c(rep("character", 2), rep("factor", 4) , rep(NA, 32)), fileEncoding = 'latin1') %>% 
  mutate(densite = P14_POP / SUPERF,
    tx_natal = 1000 * NAISD15 / P14_POP,
    tx_mort = 1000 * DECESD15 / P14_POP)

# Utilisez la fonction summary() pour obtenir un résumé de l’ensemble des variables de la table df
# Calculez maintenant les moyenne, médiane, écart-type et variance de la variable de densité de population. Que constatez-vous ?
#   Utilisez le paramètre na.rm = T pour gérer les valeurs manquantes
# Calculez à présent les quartiles puis déciles de cette variable
# Calculez la version centrée réduite de la variable de densité. 
# Rappel sur la définition de centrer réduite : https://fr.wikipedia.org/wiki/Variable_centr%C3%A9e_r%C3%A9duite

# Tableaux croisés :

# Calculer le nombre de communes par type d’espace à l’aide de la fonction table, et le pourcentage associé
# Calculer le nombre de communes par région et type d’espace, et les pourcentages associés
