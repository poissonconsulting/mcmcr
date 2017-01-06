#' Number of terms.
#'
#' @param x The object to calculate the number of terms for.
#' @param ... Not used.
#' @return A count of the number of terms.
#' @export
nterms <- function(x, ...) {
  UseMethod("nterms")
}

#' @export
nterms.mcmcarray <- function(x, ...) {
  
  as.integer(prod(dim(x)[-(1:2)]))
}

#' @export
nterms.mcmcr <- function(x, ...) {
  
  sum(vapply(x, nterms, 1L))
}
