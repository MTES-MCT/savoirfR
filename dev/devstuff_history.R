# permet d'ignorer le fichier, ainsi pas de note lors du check
usethis::use_build_ignore("devstuff_history.R")

# Définir une licence
usethis::use_gpl3_license("GPL-3")

# package utile
usethis::use_package("utils")

# Crée un fichier .R dans le dossier R
usethis::use_r("skeleton.R")

usethis::use_build_ignore("how_to.md")

# creation de la documentation des data
# usethis::use_r("doc_nomdeladata")

usethis::use_vignette("exercices_module_introduction_a_R")
usethis::use_vignette("exercices_module_datapreparation_R")
usethis::use_vignette("exercices_module_datavisualisation_R")
usethis::use_pkgdown()
usethis::use_github_action("pkgdown")
usethis::use_readme_rmd()
usethis::use_news_md()
usethis::use_r("charge_exo")
usethis::use_r("rmd_to")
usethis::use_package("dplyr")
usethis::use_package("stringr")
usethis::use_package("magrittr")
usethis::use_package("rlang")
  
usethis::use_package('forcats', type = "Suggests")
usethis::use_package('gganimate', type = "Suggests")
usethis::use_package('ggiraph', type = "Suggests")
usethis::use_package('ggplot2', type = "Suggests")
usethis::use_package('hrbrthemes', type = "Suggests")
usethis::use_package('kableExtra', type = "Suggests")
usethis::use_package('sf', type = "Suggests")
usethis::use_package('tidyr', type = "Suggests")
usethis::use_package('class', type = "Suggests")
usethis::use_package('RcppRoll', type = "Suggests")
usethis::use_package('lubridate', type = "Suggests")
usethis::use_package('readxl', type = "Suggests")
usethis::use_package('tidyverse', type = "Suggests")
usethis::use_dev_package('COGiter', type = "Suggests")

usethis::use_build_ignore("dev/")
usethis::use_logo(img = "~/Mes images/savoirfR/hex-savoirfR2.png")


extract_r_files(module = 5)
extract_r_files(module = 2)
