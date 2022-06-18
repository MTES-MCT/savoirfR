#' Charger les exos des modules
#'
#' @param ... chemin partant de vignettes vers le l'exercice
#'
#' @return
#' @export
#'
#' @examples
#' charge_exo("m5", "exo1.rmd")
charge_exo <- function(...) {
  system.file("vignettes", ... , package = "savoirfR", mustWork = TRUE)
}
