#' @export
anyNA.mcmcarray <- function(x, recursive = FALSE) {
  x <- unclass(x)
  anyNA(x, recursive = recursive)
}

#' @export
anyNA.mcmcr <- function(x, recursive = FALSE) {
  x <- lapply(x, anyNA, recursive = recursive)
  any(unlist(x))
}
