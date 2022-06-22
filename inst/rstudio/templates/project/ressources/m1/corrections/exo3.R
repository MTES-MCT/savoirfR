# Exercice : Créer, filtrer, sélectionner

# Nous travaillons toujours sur la même tables des indicateurs au territoire

df <- read.csv(file = "extdata/Base_synth_territoires.csv", header = TRUE, sep = ";", dec = ",",
               colClasses = c(rep("character", 2), rep("factor", 4) , rep(NA, 32)), fileEncoding = 'latin1')

# En utilisant la fonction mutate(), créer une nouvelle variable correspondant à la densité de population
# (rapport de la population à la superficie de la commune), ainsi que les taux de natalité et de mortalité (en pour mille)

df <- mutate(df, densite = P14_POP / SUPERF,
  tx_natal = 1000 * NAISD15 / P14_POP,
  tx_mort = 1000 * DECESD15 / P14_POP)
# A l’aide de la fonction select(), créer une nouvelle table en ne conservant que :
# le code commune, le type de commune (ZAU), la région, le département et les variables que vous venez de créer.

selection <- select(df, CODGEO, ZAU, REG, DEP,
  densite, tx_natal, tx_mort)

# Enfin, ne conserver les communes correspondant à votre département de naissance et stocker ce dataframe.
# Attention au type de la variable département !

S0 <- filter(selection, DEP == "62")

#  Avec les opérateurs logiques, faire des essais pour sélectionner des échantillons différents.

S1 <- filter(selection, DEP != "62") # tout sauf le 62 :(
S2 <- filter(selection, DEP %in% c("59", "62")) # L'ancien NPdC :)
S3 <- filter(selection, !(DEP %in% c("59", "62"))) # Le "sud" de la France
S4 <- filter(selection, densite > 100) # l'urbain
S5 <- filter(selection, DEP == "62" & densite > 100) # le PdC urbain
S6 <- filter(selection, DEP == "62" | densite > 100) # le PdC et l'urbain

# Nom d’un pipe %>% !

# On peut combiner les opérations en une seule ligne à l’aide du pipe %>% :

selection_62 <- select(df, CODGEO, ZAU, REG, DEP, densite, tx_natal) %>%
  filter(DEP == "62")
