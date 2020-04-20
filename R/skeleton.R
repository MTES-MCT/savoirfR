#' get files from the exercices package
#
#' @param ... other params from the systeme.file fonction
#'
#' @import stats utils

pkg_file <- function(...) {
  system.file(..., package = 'exercices', mustWork = TRUE)
}


#' get extdata file needed for a module
#'
#' @param m module number
#' @importFrom utils read.csv2
#' @return a list of files

module_data <- function(m) {
    # if (m=='m1'){
    #   files <- list("Base_synth_territoires.csv","rp_2012.csv")
    # }
  list_data <- file.path(pkg_file('extdata'), 'list_data_module.csv')
  data <- read.csv2(list_data, colClasses = c("character"))
  files <- as.list(data[data$module=='m1',]$file)
  return(files)
}


#' Function to define the project exo_modules
#'
#' @param path path where the project is create
#' @param ...  params define by the user a the project creation
#'
#' @return create a project

exo_modules_skeleton = function(path,...) {
  
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path,'extdata'), recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path,'scripts'), recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path,'corrections'), recursive = TRUE, showWarnings = FALSE)
  
  # get module selected
  
  dots <- list(...)
  m <- dots[[1]]
  
  # copy 'extdata' folder to path
  files = module_data(m)
  extdata <- pkg_file('extdata')
  source <- file.path(extdata, files)
  
  target = file.path(path,'extdata', files)
  file.copy(source, target)
  
  # copy 'enonces' folder
  
  ressources = pkg_file('rstudio', 'templates','project', 'ressources', m, 'enonces')
  
  files = list.files(ressources, recursive = TRUE, include.dirs = FALSE)
  
  source = file.path(ressources, files)
  target = file.path(path,'scripts', files)
  file.copy(source, target)

  # copy 'corrections' folder
  
  ressources = pkg_file('rstudio', 'templates','project', 'ressources', m, 'corrections')
  
  files = list.files(ressources, recursive = TRUE, include.dirs = FALSE)
  
  source = file.path(ressources, files)
  target = file.path(path,'corrections', files)
  file.copy(source, target)
  
  
  TRUE
}
