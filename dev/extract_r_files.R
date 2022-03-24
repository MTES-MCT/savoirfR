# Liste les rmd dans le dossiers inst/vignettes
# et Extrait les enonces et les corrections des rmd et les place dans les dossiers
#

files <- list.files(file.path("inst", "vignettes"), 
                    recursive = TRUE, 
                    pattern = "[Rr](md|markdown)$")
lapply(files, FUN = function(.file) {
  module <- fs::path_dir(.file)
  rmdfile <- fs::path_file(.file)
  savoirfR::rmd_to_correction(module, rmdfile)
  savoirfR::rmd_to_enonce(module, rmdfile)
})