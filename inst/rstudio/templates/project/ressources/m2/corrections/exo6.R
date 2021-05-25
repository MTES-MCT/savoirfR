# Exercice 6 (chap 8)
# 
# Calculer à partir des tables fournies dans le fichier 'majic.RData' issues des fichiers fonciers 
# un indicateur d'étalement urbain entre 2009 et 2014 à la commune et à l'epci sur la région Pays de la Loire, et catégoriser chaque territoire.
# 
# Définitions :   
# - artificialisation = dcnt07 + dcnt09 + dcnt10 + dcnt11 + dcnt12 + dcnt13
# - indicateur_etalement_simple = évolution de l'artificialisation / évolution de la population
# - indicateur_etalement_avance, indicateur catégoriel qui vaut :    
#    * 1 si la population progresse ou reste stable alors que l'artificialisation recule ;  
#    * 2a si la population et l'artificialisation progressent ou sont stables et l'étalement urbain est inférieur ou égal à 1 (ou pop stable) ;  
#    * 2b si la population et l'artificialisation reculent et l'indicateur d'étalement urbain est supéreur à 1 ;  
#    * 2c si la population recule et l'indicateur d'étalement est compris entre 0 et 1 (inclus) ;  
#    * 3 si la population progresse, l'artificialisation progresse plus vite que la population, tout en restant inférieure ou égale à 4,9 m² ;   
#    * 4 si la population progresse, l'artificialisation est supérieure à 4,9 m², elle progresse plus vite que la population mais au plus 2 fois plus vite ;     
#    * 5 si la population progresse, l'artificialisation progresse plus de 2 fois plus vite que la population et est supérieure à 4,9 m² ;  
#    * 6 si la population recule et l'indicateur d'étalement urbain est négatif. 
                                                                                                   
                                                                                                 
rm(list = ls())

library(tidyverse)

load("extdata/majic.RData")


# pour chaque millésime de majic, on remet les données sur la nouvelle carte des territoires et on crée une variable artif

majic_2009 <- bind_rows(majic_2009_com44, majic_2009_com49, majic_2009_com53, majic_2009_com72, majic_2009_com85) %>%
  left_join(com2017, by = c("idcom" = "depcom")) %>%
  select(-idcom, -idcomtxt) %>%
  group_by(epci_2017, depcom2017) %>%
  summarise(across(everything(), sum)) %>%
  ungroup() %>%
  mutate(artif_2009 = dcnt07 + dcnt09 + dcnt10 + dcnt11 + dcnt12 + dcnt13) %>%
  select(-starts_with("dcnt"))


majic_2014 <- bind_rows(majic_2014_com44, majic_2014_com49, majic_2014_com53, majic_2014_com72, majic_2014_com85) %>%
  left_join(com2017, by = c("idcom" = "depcom")) %>%
  select(-idcom, -idcomtxt) %>%
  group_by(epci_2017, depcom2017) %>%
  summarise(across(everything(), sum))%>%
  ungroup() %>%
  mutate(artif_2014 = dcnt07 + dcnt09 + dcnt10 + dcnt11 + dcnt12 + dcnt13) %>%
  select(-starts_with("dcnt"))


# on passe également les données de population sur la nouvelle carte des territoires

p_2009 <- population_2009 %>%
  left_join(com2017, by = c("idcom" = "depcom")) %>%
  select(-idcom) %>%
  group_by(epci_2017, depcom2017) %>%
  summarise(population_2009 = sum(Population)) %>%
  ungroup()
p_2014 <- population_2014 %>%
  left_join(com2017, by = c("idcom" = "depcom")) %>%
  select(-idcom) %>%
  group_by(epci_2017, depcom2017) %>%
  summarise(population_2014 = sum(Population)) %>%
  ungroup()

# indicateur à la commune
# on joint les 4 tables précédentes par commune et on calcule les indicateurs
etalement_urbain_commune <- majic_2009 %>%
  left_join(majic_2014) %>%
  left_join(p_2009) %>%
  left_join(p_2014) %>%
  mutate(
    evoarti = 100 * artif_2014 / artif_2009 - 100,
    evopop = 100 * population_2014 / population_2009 - 100,
    indicateur_etalement_simple = evoarti / evopop,
    indicateur_etalement_avance = case_when(
      evoarti < 0 & evopop >= 0 ~ "1",
      evoarti >= 0 & evopop >= 0 & (evoarti / evopop <= 1 | evopop == 0) ~ "2a",
      evoarti < 0 & evopop < 0 & evoarti / evopop > 1 ~ "2b",
      evopop < 0 & evoarti / evopop >= 0 & evoarti / evopop <= 1 ~ "2c",
      evopop > 0 & evoarti > 0 & evoarti <= 4.9 & evoarti / evopop > 1 ~ "3",
      evopop > 0 & evoarti > 4.9 & evoarti / evopop > 1 & evoarti / evopop <= 2 ~ "4",
      evopop > 0 & evoarti > 4.9 & evoarti / evopop > 2 ~ "5",
      evopop < 0 & evoarti / evopop < 0 ~ "6"
    )
  )

# Indicateur à l'EPCI
# on joint les 4 tables précédentes par commune, on aggrège les compteurs par EPCI et on calcule les indicateurs

etalement_urbain_epci <- majic_2009 %>%
  left_join(majic_2014) %>%
  left_join(p_2009) %>%
  left_join(p_2014) %>%
  select(-depcom2017) %>%
  group_by(epci_2017) %>%
  summarise_all(sum) %>%
  mutate(
    evoarti = 100 * artif_2014 / artif_2009 - 100,
    evopop = 100 * population_2014 / population_2009 - 100,
    indicateur_etalement_simple = evoarti / evopop,
    indicateur_etalement_avance = case_when(
      evoarti < 0 & evopop >= 0 ~ "1",
      evoarti >= 0 & evopop >= 0 & (evoarti / evopop <= 1 | evopop == 0) ~ "2a",
      evoarti < 0 & evopop < 0 & evoarti / evopop > 1 ~ "2b",
      evopop < 0 & evoarti / evopop >= 0 & evoarti / evopop <= 1 ~ "2c",
      evopop > 0 & evoarti > 0 & evoarti <= 4.9 & evoarti / evopop > 1 ~ "3",
      evopop > 0 & evoarti > 4.9 & evoarti / evopop > 1 & evoarti / evopop <= 2 ~ "4",
      evopop > 0 & evoarti > 4.9 & evoarti / evopop > 2 ~ "5",
      evopop < 0 & evoarti / evopop < 0 ~ "6"
    )
  )
# Deux graphiques de visualisation de notre indicateur
ggplot(data = etalement_urbain_epci) +
  geom_point(aes(x = evoarti, y = evopop, color = indicateur_etalement_avance)) +
  theme_minimal() +
  labs(
    title = "Indicateur d'étalement urbain sur les epci de la région Pays de la Loire",
    x = "Evolution de l'artificialisation", y = "Evolution de la démographie",
    color = "",
    caption = "Source : Majic et Recensement de la population\nCarte des territoires 2017"
  )

ggplot(data = etalement_urbain_commune) +
  geom_point(aes(x = evoarti, y = evopop, color = indicateur_etalement_avance),
    size = 0.5, alpha = 0.5
  ) +
  theme_minimal() +
  labs(
    title = "Indicateur d'étalement urbain sur les communes de la région Pays de la Loire",
    subtitle = "Entre 2009 et 2014", x = "Evolution de l'artificialisation",
    y = "Evolution de la démographie", color = "",
    caption = "Source : Majic et Recensement de la population\nCarte des territoires 2017"
  )
