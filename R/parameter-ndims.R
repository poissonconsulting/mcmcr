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
  vapply(x, )
  terms <- as.term(x)
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
