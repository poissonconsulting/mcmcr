#' Parameter Dimensions
#'
#' Gets the parameter dimensions of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
parameter_dims <- function(x, ...) UseMethod("parameter_dims")

#' @export
parameter_dims.default <- function(x, ...) {
  terms <- as.term(x)
  dims <- dims_terms(terms)


}

#' @export
parameter_dims.mcarray <- function(x, ...) {
  dims <- dims(x)
  dims(x)[1:(length(dims)-2)]
}

#' @export
parameter_dims.mcmcarray <- function(x, ...) dims(x)[-(1:2)]

#' @export
parameter_dims.mcmcr <- function(x, ...) lapply(x, parameter_dims)
