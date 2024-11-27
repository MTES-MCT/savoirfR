# ---
# title: "Exercice 1 -  module 7"
# ---
# Créer un objet contenant les points de p qui intersectent le polygone a, à partir du code suivant :
# ```r
# library(sf)
# library(tidyverse)
# # polygone (a - orange)
# a_poly <- st_polygon(list(rbind(c(-1, -1), c(1, -1), c(1, 1), c(-1, -1))))
# a <- st_sfc(a_poly)
# # multi-points (p - noirs)
# p_matrix <- matrix(c(0.5, 1, -1, 0, 0, 1, 0.5, 1), ncol = 2)
# p_multi <- st_multipoint(x = p_matrix)
# p <- st_cast(st_sfc(p_multi), "POINT")
# ```


