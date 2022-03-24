# ---
# title: "Exercices 1 -  module 5"
# ---
# ## Exercice 1
#  A partir des données de la table `rpls_aggrege_large` (rpls_aggrege_large.RData), créer un nuage de point entre :
#  
#   - le % de parc social de moins de 5 ans (variable `Parc_de_moins_de_5_ans_pourcent`) ;
#   - et le pourcentage de logement avec un DPE gaz à effet de serre de classe A, B ou C (variable `DPE_GES_classe_ABC_pourcent`) ;
#   - et une couleur différente pour distinguer les EPCI de la région Pays de la Loire
#     (la variable `epci_2017_52` vaut 1 si l'EPCI appartient à la région PDL, 0 sinon).
#     
library(ggplot2)
library(dplyr)

load(system.file("extdata", "rpls_aggrege_large.RData", package = "savoirfR"))
#load("extdata/rpls_aggrege_large.RData")

# Résultat attendu :
# Solution
ggplot(data = rpls_aggrege_large  %>%
  #on filtre la table sur les données EPCI
         filter(TypeZone=="Epci")) + 
  # geom_point permet la représentation sous forme de nuage de points, 
  # en définissant les variables à afficher en ordonnée et en abscisse, 
  # et la 3eme variable discriminante par couleur
  geom_point(aes(x=Parc_de_moins_de_5_ans_pourcent,
                 y=DPE_GES_classe_ABC_pourcent,
                 color=epci_2017_52),
             # la valeur alpha permet de paramètrer la transparence des points
             alpha=.5,
             # la valeur size permet de paramètrer la taille des points
             size=.5 )

