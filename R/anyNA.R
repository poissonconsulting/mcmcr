#' @export
anyNA.mcmcarray <- function(x, recursive = FALSE) {
  x %<>% unclass()
  anyNA(x, recursive = recursive)
}

#' @export
anyNA.mcmcr <- function(x, recursive = FALSE) {
  x %<>% purrr::map(anyNA, recursive = recursive)
  any(unlist(x))
}
