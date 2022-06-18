# Importer les données et premier coup d’oeil
# Nous allons travailler sur des indicateurs au territoire extrait de l'outil geoidd du ministère et exporté en csv
# Utiliser la fonction read.csv() pour importer ce fichier et stocker le dans un objet df.
# Veillez à ce que la région soit bien importée comme un facteur et non un entier.
# Inspecter le dataframe avec les fonctions vues auparavant

df <- read.csv(file = "extdata/Base_synth_territoires.csv", header = TRUE, sep = ";", dec = ",",
               colClasses = c(rep("character", 2), rep("factor", 4) , rep(NA, 32)))
str(df)

# On peut également gérer les problèmes d’encodage de caractères (si on passe de Windows à un système Unix, par exemple).

head(df)
tail(df)
names(df)
class(df) # la classe de l'objet (du point de vue langage orienté objet)
typeof(df) # le type d'objet du point de vue "interne" à R
df$CODGEO[1:10] # Captain crochet poweeeeerr !!!
class(df$CODGEO)
typeof(df$CODGEO)
length(df)
length(df$REG)
