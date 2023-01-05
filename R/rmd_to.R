
#' Ressource path
#'
#' @param ... 
#'
#'
#' @noRd
ressources_path <- function(...) {
  file.path("inst", "rstudio", "templates", "project", "ressources", ...)
}

#' Vignettes path
#'
#' @param ... 
#'
#'
#' @noRd
vignettes_path <- function(...) {
  file.path("inst", "vignettes", ...)
}


#' rmd_to
#'
#' @param module "m1"
#' @param rmdfile "exo1.rmd"
#' @param folder corrections ou enonces
#' @param purl TRUE (pour extraire le code R) ou FALSE pour ignorer le code R
#' 
#' @import knitr
#' @importFrom fs path_ext_set
#'
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

#' rmd_to_correction
#'
#' @param module "m1"
#' @param rmdfile "exo1.rmd"
#' 
#' @export
rmd_to_correction <- function(module, rmdfile) {
  out <- rmd_to(module = module,
                rmdfile = rmdfile,
                folder = "corrections",
                purl = TRUE)
  clean_r(rfile = out)
  out
}

#' rmd_to_enonce
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



#' Clean R correction file
#'
#' @param rfile character
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
    #remove empty lines and chunk opts and lines 'resultats attendus : '
    dplyr::filter(!stringr::str_detect(.data$value, "(#' $)|(^##)|sultat attendu|sultats attendus|sultat intermédiaire|sultats intermédiaires")) %>%
    #replace #' by #, and replace load with system file by basic load
    dplyr::mutate(value = stringr::str_replace(.data$value, "#'", '#')) %>% 
    dplyr::mutate(value = gsub('system.file("extdata", "', '"extdata/', .data$value, fixed = TRUE)) %>%
    dplyr::mutate(value = gsub(', package = "savoirfR")', '', .data$value, fixed = TRUE)) %>%
    dplyr::mutate(value = gsub('(.*)knitr::knit_child\\(savoirfR::charge_exo\\((.*)', '', .data$value, perl = TRUE)) %>%
    dplyr::pull() %>%
    writeLines(con = rfile   )
}
