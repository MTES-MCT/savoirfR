#' Liste les exercices d'un module au format rmd, presents dans le dossiers inst/vignettes du module, puis en extrait/nettoie/colle le contenu  dans des scripts R d'enonces et de corrections, rendus accessibles aux stagiaires utilisant le package savoirFr pour réaliser les exercices, au niveau du dossier inst/rstudio/templates/project/ressources du module. N'impacte que le package savoirfR.
#' 
#'
#' @param module le numero du dossier
#'
#' @return nothing
#' @export
#'
#' @examples
#' \dontrun{
#' extract_r_files(module = 5)
#' }
extract_r_files <- function(module = 5) {
  files <- list.files(file.path("inst", "vignettes", paste0("m", module)), 
                      recursive = TRUE, 
                      pattern = "[Rr](md|markdown)$")
  if(length(files) == 0) {
    message(paste0("le repertoire inst/vignettes/m", module, "ne contient aucun fichier. Placez-y vos exercices au format rmd."))
  }
  
  lapply(files, FUN = function(.file) {
    module <- paste0("m", module)
    rmdfile <- .file
    savoirfR::rmd_to_correction(module, rmdfile)
    savoirfR::rmd_to_enonce(module, rmdfile)
  }) 
  
}
