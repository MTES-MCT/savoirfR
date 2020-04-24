# Produire une carte du Loiret à l’EPCI du taux de logements collectifs dans le parc locatif social.
# 

library(ggplot2)
library(tidyverse)
library(sf)

load("extdata/rpls_aggrege.RData")
load("extdata/Carte_EPCI_France.RData")

tt <- Carte_EPCI_France %>% 
  filter(CODE_DEPT=="45") %>% 
  left_join(rpls_aggrege) %>% 
  filter(Indicateur=="Logements collectifs_pourcent")

ggplot(data=tt)+
  geom_sf(aes(geometry=geometry, fill=Valeur))+
  # définition de la palette de couleur
  scale_fill_continuous(low = "#87CEFF", high = "#0B3E87")+
  labs(title="Taux de logements collectifs par EPCI dans le parc locatif social",
       subtitle="Département du Loiret",
       caption="Source: Répertoire Locatif Social")+
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())