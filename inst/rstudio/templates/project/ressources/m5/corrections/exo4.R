# ---
# title: "Exercice 4 -  module 5"
# ---  
# A partir de la table rpls_aggrege, réaliser une facette sur un diagramme barre avec :       
#  - en variable discrète les régions (axe des x),    
#  - en variables continues les indicateurs suivants (axe des y, les facettes) :      
#     - % de logements de 3 et 4 pièces   
#     - % DPE énergie A, B, C   
#     - % DPE GES A, B, C   
#     - % de parc de moins de 5 ans   
#  - une façon d'identifier la région Pays de la Loire.   
#  
load("extdata/rpls_aggrege.RData")



library(ggplot2)
library(dplyr)
library(forcats)
library(hrbrthemes)

gg <- rpls_aggrege %>%
  filter(TypeZone == "Régions",
         Indicateur %in% c("3 et 4 pièces_pourcent",
                           "DPE GES classe ABC_pourcent",
                           "DPE énergie classe ABC_pourcent",
                           "Parc de moins de 5 ans_pourcent")) %>%
  mutate(Indicateur = fct_recode(Indicateur,
                                 `Logements de 3 et 4 pièces` = "3 et 4 pièces_pourcent",
                                 `Logements avec DPE énergie de classe A,B,C` = "DPE énergie classe ABC_pourcent",
                                 `Logements avec DPE GES de classe A,B,C` = "DPE GES classe ABC_pourcent",
                                 `Logements social de moins de 5 ans` = "Parc de moins de 5 ans_pourcent"),
         r52 = if_else(Reg_2017 == "52", 1, 0.65)) %>%
  ggplot() +
  # On utilise l'indicatrice de la région Pays de la Loire pour mapper la transparence
  geom_col(aes(x = nReg_2017, y = Valeur, fill = Indicateur, alpha = r52)) +
  # on pivote les axes pour mieux lire les noms de régions
  coord_flip() +
  # on choisit un theme minimaliste
  theme_minimal() +
  # On définit l'échelle de couleur de remplissage à utiliser
  scale_fill_ipsum() +
  # On définit la variable facette
  facet_wrap("Indicateur") +
  # On supprime la légende
  theme(legend.position = "none") +
  # On adapte les titres
  labs(title = "mon premier facet", y = "En % du parc social", x = "")


# solution 1 : On définit les valeurs maximum et minimum de transparence que l'on veut voir
gg + scale_alpha_continuous(range = c(.65, 1))

# solution 2 : On indique via la fonction scale_xx_identity que les valeurs peuvent être utilisées telles quelles
# gg + scale_alpha_identity()

# solution 3 : On indique via le paramètre rescaler de la fonction scale_alpha_continuous que les valeurs peuvent être utilisées telles quelles
# gg + scale_alpha_continuous(rescaler = ~.x)


