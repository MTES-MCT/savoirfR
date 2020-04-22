# Exercice : créer des graphiques

# Nous allons travailler sur des indicateurs au territoire extrait de l'outil geoidd du ministère et exporté en csv 
# avec les variables que nous avons calculé à l'exercice précédent

df <- read.csv(file = "extdata/Base_synth_territoires.csv",
               sep = ";", dec = ",",
               colClasses = c(NA, "NULL", "character", "NULL","NULL","NULL",
                              NA, NA, NA, NA, rep("NULL", 28))) %>% 
  mutate(densite = P14_POP / SUPERF,
         tx_natal = 1000 * NAISD15 / P14_POP,
         tx_mort = DECESD15 / P14_POP)

# À l’aide de l’aide mémoire ggplot2 :
#   
# - Réaliser un histogramme de la population communale
# - Transformer les données avec la fonction log pour y voir plus clair
# - Faire un barplot du nombre de communes par type ZAU
# - Utiliser le paramètre fill de la fonction aes() pour améliorer le graphique
# - Réaliser un graphique (nuage de points) croisant la densité de population et le taux de mortalité
# - Ajouter une dimension supplémentaire avec la couleur des points (paramètre color de aes())

