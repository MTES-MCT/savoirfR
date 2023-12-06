# ---
# title: "Exercices 8 -  module 5"
# ---  
# A partir de la table `rpls_aggrege_large`, produire un tableau du nombre de logements collectifs et individuels (RPLS) par départements en région Centre-Val de Loire : 1 ligne par département + 1 ligne avec le total de la région.  
load("extdata/rpls_aggrege_large.RData")



library(kableExtra)
library(dplyr)


rpls_DEP_R24 <- rpls_aggrege_large %>%
  # filtre pour ne conserver que les données départementales et régionale du Centre-Val de Loire)
  filter(TypeZone %in% c("Départements", "Régions"), nReg_2017 == "Centre-Val de Loire") %>%
  # tri de la table
  arrange(TypeZone, Zone) %>%
  # selection des variables souhaitees dans la table de sortie
  select(Zone, Logements_collectifs, Logements_individuels) %>%
  # specification des intitulés
  setNames(c("Zone", "Nombre de logements collectifs", "Nombre de logements individuels")) %>%
  kable("html", caption = "Chiffres clés RPLS") %>%
  # Parametrage des effets de style:  alternance des fonds de lignes (blanc/gris) et surbrillance au passage de la souris
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  # Parametrage de la 7eme ligne-ligne région: écriture en blanc sur fond gris.
  row_spec(7, bold = T, color = "white", background = "grey")

rpls_DEP_R24


