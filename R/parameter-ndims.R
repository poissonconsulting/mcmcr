#' Number of Parameter Dimensions
#'
#' Gets an integer vector of the number of dimensions of the parameters of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
parameter_ndims <- function(x, ...) UseMethod("parameter_ndims")

#' @export
parameter_ndims.default <- function(x, ...) {
  terms <- terms(x)
  parameters <- parameters(terms)
  vapply(parameters, function(p, terms) { }, 1L, terms = terms)
}
