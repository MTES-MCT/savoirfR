#' @import stats utils

exo_file = function(...) {
  system.file(..., package = 'exercices', mustWork = TRUE)
}

#' @importFrom xfun read_utf8
#' @importFrom xfun write_utf8


exo_skeleton = function(path,...) {
  
  # ensure directory exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path,'extdata'), recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path,'scripts'), recursive = TRUE, showWarnings = FALSE)
  
  # copy 'extdata' folder to path
  resources = exo_file('extdata')
  
  files = list.files(resources, recursive = TRUE, include.dirs = FALSE)
  
  source = file.path(resources, files)
  target = file.path(path,'extdata', files)
  file.copy(source, target)
  
  # copy 'ressources' folder
  
  resources = exo_file('rstudio', 'templates', 'project', 'ressources')
  
  files = list.files(resources, recursive = TRUE, include.dirs = FALSE)
  
  source = file.path(resources, files)
  target = file.path(path,'scripts', files)
  file.copy(source, target)
  
  
  TRUE
}
