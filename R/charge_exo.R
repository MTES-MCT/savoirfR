#' Charger un exercice de module
#' @description
#' Pour ramener un exercice dans les articles du site de savoirfR ou dans le support de formation, 
#' on mobilise cette fonction dans les options d'un chunk. 
#' Par exemple pour afficher la consigne de l'exercice 1 dans le support de formation du module 5, on insère :
#'     ```{r mod5_exo1, child=charge_exo("m5", "exo1.rmd"), echo=FALSE}
#'     
#'     ```
#' @references Pour en savoir plus sur le fonctionnement de child : https://yihui.org/knitr/demo/child/
#'
#' @param ... chemin vers l'exercice en partant du dossier `savoirfR/inst/vignettes/` du projet savoirfR 
#' @returns le chemin vers l'exercice, adapté au contexte d'installation de de la fonction
#'
#' @export
#'
#' @examples
#' charge_exo("m5", "exo1.rmd")
charge_exo <- function(...) {
  system.file("vignettes", ... , package = "savoirfR", mustWork = TRUE)
}
