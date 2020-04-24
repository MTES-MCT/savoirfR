# Reprendre le nuage de point obtenu à partir des données ODD :
# taux de mortalité maternelle (Maternal_mortality_ratio) 
# en fonction du produit intérieur brut (Gross_Domestic_Product_GDP) (Chapitre 4.1)

# Obtenir ce graphique pour le web avec des infos bulles regroupant le nom du continent, 
# de la zone et les données associées

library(highcharter)


load("extdata/ODD_graphique1.RData")

hchart(ODD_graphique1,"scatter",hcaes(x=Gross_Domestic_Product_GDP,
                                  y=Maternal_mortality_ratio,
                                  color=Continent)) %>%
  hc_plotOptions(series=list(shadow='false')) %>% 
  hc_tooltip(
    pointFormat = '<b>{point.Continent}</b><br/><b>{point.Parent_Zone_libelle}</b><br/>PIB de {point.x} un taux de mortalié maternelle de {point.y} (pour 100 000 naissances)'
  )