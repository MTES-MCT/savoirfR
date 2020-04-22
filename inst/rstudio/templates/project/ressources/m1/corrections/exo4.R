# Exercice : calcul de statistiques

# Nous allons travailler sur des indicateurs au territoire extrait de l'outil geoidd du ministère et exporté en csv 
# avec les variables que nous avons calculé à l'exercice précédent
df <- read.csv(file = "extdata/Base_synth_territoires.csv",
               sep = ";", dec = ",",
               colClasses = c(NA, "NULL", "character", "NULL","NULL","NULL",
                              NA, NA, NA, NA, rep("NULL", 28))) %>% 
  mutate(densite = P14_POP / SUPERF,
         tx_natal = 1000 * NAISD15 / P14_POP,
         tx_mort = DECESD15 / P14_POP)

# Utilisez la fonction summary() pour obtenir un résumé de l’ensemble des variables de la table df

summary(df)

# Calculez maintenant les moyenne, médiane, écart-type et variance de la variable de densité de population. Que constatez-vous ?

df %>% pull(densite) %>% mean()
df %>% pull(densite) %>% sd()
df %>% pull(densite) %>% median()
df %>% pull(densite) %>% var()

# Utilisez le paramètre na.rm = T pour gérer les valeurs manquantes

df %>% pull(densite) %>% mean(na.rm = T)
df %>% pull(densite) %>% sd(na.rm = T)
df %>% pull(densite) %>% median(na.rm = T)
df %>% pull(densite) %>% var(na.rm = T)

# Calulez à présent les quartiles puis déciles de cette variable

df %>% pull(densite) %>% quantile(na.rm = T)
seq(0, 1, 0.1) # vérifier la séquence qu'on souhaite
df %>% pull(densite) %>% quantile(probs = seq(0, 1, 0.1), na.rm = T)

# Calculez la version centrée réduite de la variable de densité. 

df <- df %>% 
  mutate(std_dens = (densite - mean(densite, na.rm = T)) / sd(densite, na.rm = T))

# Rappel sur la définition de centrer réduire : https://fr.wikipedia.org/wiki/Variable_centr%C3%A9e_r%C3%A9duite

# Tableaux croisés :
  
# Calculer le nombre de communes par type d’espace à l’aide de la fonction table, et le pourcentage associé
t <- table(df$ZAU2)
t
100 * prop.table(t) %>% round(digits = 4)

# Calculer le nombre de communes par région et type d’espace, et les pourcentages associés

t <- table(df$REG, df$ZAU2)
t
100 * prop.table(t) %>% round(digits = 4)

