# ## Exercice 8
# Produire un tableau du nombre de logements collectifs et individuels (RPLS) par départements en région Centre-Val de Loire.
# Le résultat attendu :
library(tidyverse)
library(kableExtra)
load(system.file("extdata", "rpls_aggrege_large.RData", package = "savoirfR"))
#load("extdata/rpls_aggrege_large.RData")

rpls_DEP_R24  <- rpls_aggrege_large %>% 
  filter(TypeZone %in% c("Départements","Régions"),nReg_2017=="Centre-Val de Loire") %>% 
  arrange(TypeZone,Zone) %>%
  select(Zone,Logements_collectifs,Logements_individuels)%>% 
  setNames(c("Zone","Nombre de logements collectifs","Nombre de logements individuels")) %>% 
  kable("html",caption="Chiffres clés RPLS") %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>% 
  row_spec(7, bold = T, color = "white", background = "grey")
rpls_DEP_R24

