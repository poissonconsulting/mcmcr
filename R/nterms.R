#' Number of terms
#'
#' Gets the number of terms for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A count of the number of terms.
#' @export
#' @examples
#'
nterms <- function(x, ...) {
  UseMethod("nterms")
}

#' @export
nterms.default <- function(x, ...) {
  length(terms(x))
}

#' @export
nterms.mcmcarray <- function(x, ...) {
  as.integer(prod(dim(x)[-(1:2)]))
}

#' @export
nterms.mcmcr <- function(x, ...) {
  sum(vapply(x, nterms, 1L))
}
