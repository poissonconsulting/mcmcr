#' Number of Terms
#'
#' Gets the number of terms for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A count of the number of terms.
#' @export
#' @examples
#' nterms(mcmcr_example)
nterms <- function(x, ...) {
  UseMethod("nterms")
}

#' @describeIn nterms Number of terms for an object
#' @export
nterms.default <- function(x, ...) {
  check_unused(...)
  length(terms(x))
}

#' @describeIn nterms Number of terms for an mcmcarray object
#' @export
nterms.mcmcarray <- function(x, ...) {
  check_unused(...)
  as.integer(prod(dim(x)[-(1:2)]))
}

#' @describeIn nterms Number of terms for an mcmcr object
#' @export
nterms.mcmcr <- function(x, ...) {
  check_unused(...)
  sum(vapply(x, nterms, 1L))
}

#' @describeIn nterms Number of terms for an mcmcrs object
#' @export
nterms.mcmcrs <- function(x, ...) {
  check_unused(...)
  nterms(x[[1]])
}
