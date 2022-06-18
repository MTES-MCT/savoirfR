#permet d'ignorer le fichier, ainsi pas de note lors du check
usethis::use_build_ignore("devstuff_history.R")

# Définir une licence
usethis::use_gpl3_license("GPL-3")

# package utile
usethis::use_package("utils")

# Crée un fichier .R dans le dossier R
usethis::use_r("skeleton.R")

usethis::use_build_ignore("how_to.md")

#creation de la documentation des data
#usethis::use_r("doc_nomdeladata")

usethis::use_vignette("exercices_module_introduction_a_R")
usethis::use_vignette("exercices_module_datapreparation_R")
usethis::use_vignette("exercices_module_datavisualisation_R")
usethis::use_pkgdown()
usethis::use_github_action("pkgdown")
usethis::use_readme_rmd()
usethis::use_news_md()
usethis::use_logo(img = "~/Mes images/savoirfR/hex-savoirfR2.png")
