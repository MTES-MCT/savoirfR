#' get files from the exercices package
#' @param ... other params from the systeme.file fonction
#' @import stats utils
#' @keywords internal
pkg_file <- function(...) {
  system.file(..., package = 'savoirfR', mustWork = TRUE)
}

#' get extdata file needed for a module
#' @param m module number
#' @importFrom utils read.csv2
#' @return a list of files
#' @keywords internal
module_data <- function(m) {
  list_data <- file.path(pkg_file('extdata'), 'list_data_module.csv')
  data <- read.csv2(list_data, colClasses = c("character"))
  files <- as.list(data[data$module == m, ]$file)
  return(files)
}


#' Function to define the project exo_modules
#'
#' @param path path where the project is create
#' @param ...  params define by the user a the project creation, dans notre cas module suivi par le stagiaire 
#' (cf liste des parametres possible dans le fichier. dcf de `inst/rstudio/templates/project`)
#' @return create a project
#' @keywords internal
#' 
exo_modules_skeleton = function(path, ...) {

  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, 'scripts'), recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, 'corrections'), recursive = TRUE, showWarnings = FALSE)

  # get module selected

  dots <- list(...)
  m <- dots[[1]]

  # copy 'extdata' folder to path if needed
  files = module_data(m)
  if(length(files) > 0) {
    dir.create(file.path(path, 'extdata'), recursive = TRUE, showWarnings = FALSE)
    extdata <- pkg_file('extdata')
    source <- file.path(extdata, files)
    target = file.path(path, 'extdata')    
    file.copy(source, target, recursive = TRUE) 
  }

  # copy 'enonces' folder
  ressources = pkg_file('rstudio', 'templates', 'project', 'ressources', m, 'enonces')
  files = list.files(ressources, recursive = TRUE, include.dirs = FALSE)
  source = file.path(ressources, files)
  target = file.path(path, 'scripts', files)
  file.copy(source, target)

  # copy 'corrections' folder
  ressources = pkg_file('rstudio', 'templates', 'project', 'ressources', m, 'corrections')
  files = list.files(ressources, recursive = TRUE, include.dirs = FALSE)
  source = file.path(ressources, files)
  target = file.path(path, 'corrections', files)
  file.copy(source, target)
  
  # M6 corrections are special, need to be rendered as a website
  # so we need to rename ex1 file from index.Rmd to cheesedown_exo1.Rmd
  # and to get extra files as images, css...
  if(m == 'm6') {
    file.rename(from = file.path(path, 'corrections', "index.Rmd"), 
                to =   file.path(path, 'corrections', "cheesedown_exo1.Rmd"))  
    extra_files_source = list.files(paste(ressources, c("img", "www"), sep = "/"), recursive = TRUE, full.names = TRUE) 
    extra_files_dest = file.path(path, gsub(".*corrections/", "", extra_files_source))
    dir.create(file.path(path, "img"))
    dir.create(file.path(path, "www"))
    file.copy(extra_files_source, extra_files_dest, recursive = TRUE)
    unlink(file.path(path, 'corrections', "_site.yml"))
  }

  
  TRUE
}
