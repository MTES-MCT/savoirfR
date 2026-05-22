
#' Ressource path : raccourcir le chemin vers les projets des stagiaires
#' @param ... 
#' @noRd
ressources_path <- function(...) {
  file.path("inst", "rstudio", "templates", "project", "ressources", ...)
}

#' Vignettes path : raccourcir le chemin vers les Rmd où sont saisis les exercices
#' @param ... 
#' @noRd
vignettes_path <- function(...) {
  file.path("inst", "vignettes", ...)
}


#' rmd_to : fonction d'extraction Rmd primitive
#' @description
#' Principe : la fonction `rmd_to()` extrait le code R de l'exercice saisi au format Rmd dans `inst/vignettes`, grâce à knitr::purl(), 
#' puis l'injecte dans un script R qu'elle enregistre dans le projet mis a disposition du stagiaire (soit corrections, soit enonces).
#' En fonction du paramètre `purl` on conserve ou non le code de la correction (TRUE pour le conserver, cas des scripts de correction)
#' Les lignes de texte du Rmd initial sont passées en commentaires de script (débutant par #').
#'
#' @param module "m1"
#' @param rmdfile "exo1.rmd"
#' @param folder corrections ou enonces
#' @param purl TRUE (pour extraire le code R) ou FALSE pour ignorer le code R
#' 
#' @import knitr
#' @importFrom fs path_ext_set
#' @examples
#' \dontrun{
#' rmd_to(module = "m7", rmdfile = "exo2.rmd")
#' }
#' @seealso [knitr::purl()]
rmd_to <- function(module, rmdfile, folder = "corrections", purl = TRUE) {
  old_purl_opts <- knitr::opts_chunk$get('purl')
  knitr::opts_chunk$set(purl = purl)
  rfile <- fs::path_ext_set(rmdfile, "R")
  path <- ressources_path(module, folder, rfile)
  knitr::purl(vignettes_path(module, rmdfile),
              output = path, 
              documentation = 2)
  knitr::opts_chunk$set(purl = old_purl_opts)
  return(path)
}


#' Clean R file
#' @description
#' Nettoyage des scripts R préparés par la fonction `rmd_to()`
#' 
#' @param rfile character l'adresse du fichier a nettoyer par exemple : 
#'  "inst/rstudio/templates/project/ressources/m7/corrections/exo2.R"
#'
#' @importFrom dplyr as_tibble filter mutate pull
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom stringr str_detect str_replace
#'
#' @export
clean_r <- function(rfile) {
  res <- readLines(rfile)
  res %>% 
    dplyr::as_tibble() %>%
    # remove empty lines and chunk opts and lines 'resultats attendus : '
    dplyr::filter(!stringr::str_detect(.data$value, "(#' $)|(^##)|sultat attendu|sultats attendu|^#' ```")) %>%
    # replace #' by #, and replace load with system file by basic load
    dplyr::mutate(value = stringr::str_replace(.data$value, "#'", '#')) %>% 
    dplyr::mutate(value = gsub('system.file("extdata", "', '"extdata/', .data$value, fixed = TRUE)) %>%
    dplyr::mutate(value = gsub(', package = "savoirfR")', '', .data$value, fixed = TRUE)) %>%
    # specifique M6 : remplacer les knit d'e-frame par un lien vers le resultat compile 1/2
    dplyr::mutate(value = gsub('knitr::include_url(url = "', "# resultat visible sur ", .data$value, fixed = TRUE)) %>%
    # specifique M6 : remplacer les knit d'e-frame par un lien vers le resultat compile 2/2
    dplyr::mutate(value = gsub('html")', 'html', .data$value, fixed = TRUE)) %>%
    dplyr::pull() %>%
    writeLines(con = rfile)
}



#' rmd_to_correction 
#' @description
#' Mise en place d'un script de correction à partir de l'exercice Rmd saisi dans `inst/vignettes`
#'
#' @param module "m1"
#' @param rmdfile "exo1.rmd"
#' 
#' @export
rmd_to_correction <- function(module, rmdfile) {
  if(module == "m6") {
    # pour le module 6 dedie aux Rmd, on ne fait rien
    # les fichiers RMD de corrections sont a placer directement dans le dossier ad-hoc
    out <- ""
  } else {
    out <- rmd_to(module = module,
                  rmdfile = rmdfile,
                  folder = "corrections",
                  purl = TRUE)
    clean_r(rfile = out)
  }
  return(out)
}

#' rmd_to_enonce
#' @description
#' Mise en place d'un script de consignes à partir de l'exercice Rmd saisi dans `inst/vignettes`
#'
#' @param module "m1"
#' @param rmdfile "exo1.rmd"
#'
#' @export
rmd_to_enonce <- function(module, rmdfile) {
  out <- rmd_to(module = module,
                rmdfile = rmdfile,
                folder = "enonces",
                purl = FALSE)
  clean_r(rfile = out)
  out
}




