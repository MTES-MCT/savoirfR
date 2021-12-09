# Exercice : Créer, filtrer, sélectionner

# Nous travaillons toujours sur la même tables des indicateurs au territoire

# En utilisant la fonction mutate(), créer une nouvelle variable correspondant à la densité de population
# (rapport de la population à la superficie de la commune), ainsi que les taux de natalité et de mortalité (en pour mille)

# A l’aide de la fonction select(), créer une nouvelle table en ne conservant que :
# le code commune, le type de commune (ZAU), la région, le département et les variables que vous venez de créer.

# Enfin, ne conserver les communes correspondant à votre département de naissance et stocker ce dataframe.
# Attention au type de la variable département !

#  Avec les opérateurs logiques, faire des essais pour sélectionner des échantillons différents.

df <- read.csv(file = "extdata/Base_synth_territoires.csv",
  sep = ";", dec = ",",
  colClasses = c(NA, "NULL", "character", "NULL", "NULL", "NULL",
    NA, NA, NA, NA, rep("NULL", 28)))
