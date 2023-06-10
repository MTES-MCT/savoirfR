# ---
# title: "Exercice 2 -  module 1"
# ---   
# Nous travaillons sur des indicateurs au territoire : "extdata/Base_synth_territoires.csv", extraits de l'outil GEOIDD du ministère et exportés en csv.
# - Utiliser la fonction `read.csv()` pour importer ce fichier et le stocker dans un objet `df`.
# - Veillez à ce que la région soit bien importée comme un facteur et non un entier.
# Inspecter le dataframe avec les fonctions vues auparavant.
df <- read.csv(file = "extdata/Base_synth_territoires.csv",
               header = TRUE, sep = ";", dec = ",",
               colClasses = c(rep("character", 2), rep("factor", 4) , rep(NA, 32)))



str(df)
head(df)
tail(df)
names(df)
class(df)
typeof(df)


