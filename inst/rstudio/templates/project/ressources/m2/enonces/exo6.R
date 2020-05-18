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




