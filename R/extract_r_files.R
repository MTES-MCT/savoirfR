#' Liste les rmd dans le dossiers inst/vignettes du module et les place dans les dossiers t Extrait les enonces et les corrections des rmd et les place dans les dossiers
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
