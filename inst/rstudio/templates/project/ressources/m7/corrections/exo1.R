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
# # lignes (l - bleues)
# l1 <- st_multilinestring(list(rbind(c(0.5, -1), c(-0.5, 1))))
# l2 <- st_multilinestring(list(rbind(c(.9, -.9), c(.5, 0))))
# l <- st_sfc(l1, l2)
# # multi-points (p - noirs)
# p_matrix <- matrix(c(0.5, 1, -1, 0, 0, 1, 0.5, 1), ncol = 2)
# p_multi <- st_multipoint(x = p_matrix)
# p <- st_cast(st_sfc(p_multi), "POINT")
# ```
library(sf)
library(tidyverse)
# polygone (a - orange)
a_poly <- st_polygon(list(rbind(c(-1, -1), c(1, -1), c(1, 1), c(-1, -1))))
a <- st_sfc(a_poly)
# lignes (l - bleues)
l1 <- st_multilinestring(list(rbind(c(0.5, -1), c(-0.5, 1))))
l2 <- st_multilinestring(list(rbind(c(.9, -.9), c(.5, 0))))
l <- st_sfc(l1, l2)
# multi-points (p - noirs)
p_matrix <- matrix(c(0.5, 1, -1, 0, 0, 1, 0.5, 1), ncol = 2)
p_multi <- st_multipoint(x = p_matrix)
p <- st_cast(st_sfc(p_multi), "POINT")

# solution st_filter
res <- st_sf(p) %>% 
  st_filter(a)
# solution tidyverse
res <- st_sf(p) %>% 
  filter(st_intersects(., a, sparse = FALSE))
# solution crochets
res <- st_sf(p)[a, , op = st_intersects]

res

