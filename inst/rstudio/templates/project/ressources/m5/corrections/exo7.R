# ---
# title: "Exercice 7 -  module 5"
# ---  
# Reprendre le nuage de point obtenu à partir des données ODD : taux de mortalité maternelle (`Maternal_mortality_ratio`) en fonction du produit intérieur brut (`Gross_Domestic_Product_GDP`) (Chapitre 9) 
# Obtenir ce graphique pour le web avec des infos bulles regroupant le nom du continent, de la zone, le PIB et le taux de mortalité maternelle.  
# Paramétrer la surbrillance du continent au survol d'élément.  
load("extdata/ODD.RData")


library(ggplot2)
library(dplyr)
library(ggiraph)

gg <- ggplot(ODD_graphique1) +
  geom_point_interactive(aes(x = log(Gross_Domestic_Product_GDP),
                             y = log(Maternal_mortality_ratio),
                             color = Continent,
                             data_id = Continent,
                             tooltip = paste(Continent, "\n", Parent_Zone_libelle,
                                             "\nPIB de", round(Gross_Domestic_Product_GDP, 1),
                                             "\nun taux de mortalié maternelle de", Maternal_mortality_ratio,
                                             "(pour 100 000 naissances)"))) +
  scale_color_brewer(type = "qual")

girafe(ggobj = gg, height_svg = 3, options = list(opts_hover(css = "fill:darkblue;")))


