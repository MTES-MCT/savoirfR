# ---
# title: "Exercice 6 -  module 5"
# ---  
# A partir du fichier `rpls_aggrege_large.RData`, réaliser un graphique en barre représentant la répartition des DPE par classe (en %).
# Le graphique sera animé par département, uniquement pour ceux de la région Centre-Val de Loire.

load("extdata/rpls_aggrege_large.RData")


library(tidyverse)
library(gganimate)
library(gifski)

# PREPARATION DE LA TABLE
rpls <- rpls_aggrege_large %>%
  # Filtre sur la zone de travail souhaitée
  filter(TypeZone == "Départements" & nReg_2017 == "Centre-Val de Loire") %>%
  # Suppression des levels non présents dans la table,
  # ce qui évite de générer des graphes vident pour les départements hors Centre-Val de Loire
  mutate(nDep_2017 = fct_drop(nDep_2017)) %>%
  # Selection des variables nécessaires
  select(nDep_2017, DPE_energie_classe_ABC_pourcent, DPE_energie_classe_D_pourcent,
         DPE_energie_classe_EFG_pourcent, DPE_energie_classe_NA_pourcent) %>%
  # Passage de la table au format long (cf module 2, chapitre 7)
  pivot_longer(-c(nDep_2017), names_to = "variable", values_to = "valeur") %>%
  # Retravail des intitulés pour ne conserver que la classe d'energie ABC/D/EGF/NA
  mutate(variable = str_remove(pattern = "DPE_energie_classe_", variable),
         variable = str_remove(pattern = "_pourcent", variable))


ggplot(data = rpls, aes(x = variable, y = valeur, fill = variable)) +
  geom_col() +
  # definition des couleurs
  scale_fill_manual(values = c("#66CD00", "#FFFF00", "#FF7F00", "#A8A8A8")) +
  # suppression de la legende
  theme(legend.position = "none") +
  # habillage: titre, libellé des axes, Source
  labs(title = "Les DPE dans le parc locatif social",
       subtitle = "En {closest_state}",
       x = "Classe d'énergie",
       y = "%",
       caption = "Source : Répertoire Locatif Social") +
  # création de l'animation
  transition_states(states = nDep_2017,
                    transition_length = 1,
                    state_length = 5)


