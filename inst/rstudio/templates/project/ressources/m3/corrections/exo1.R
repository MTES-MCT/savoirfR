# Premier exercice

# A partir des données de la table `Base_synth_territoires.csv` (Base_synth_territoires.csv),
# - effectuer une nouvelle régression avec 2 autres variables ;
# - tracer le nuage de points de ces variables ;
# - ajouter la droite de regression.

library(ggplot2)
library(readr)
library(dplyr)

base_synth_territoire <-
  read_delim(
    "inst/extdata/Base_synth_territoires.csv",
    ";",
    escape_double = FALSE,
    locale = locale(encoding = "ISO-8859-1"),
    trim_ws = TRUE
  )

model <- lm(formula = ETTOT14 ~ P14_POP, data = base_synth_territoire)
summary(model)

ggplot(data = base_synth_territoire, aes(x = P14_POP, y = ETTOT14)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
