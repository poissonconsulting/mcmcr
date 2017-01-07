#' Number of parameters
#'
#' Gets the number of parameter names for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A count of the number of parameters.
#' @export
npars <- function(x, ...) {
  UseMethod("npars")
}

#' @export
npars.mcmcr <- function(x, ...) {
  length(parameters(x))
}

#' Parameters
#'
#' Gets the parameter names for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A character vector of the parameter names.
#' @export
parameters <- function(x, ...) {UseMethod("parameters")}

#' @export
parameters.mcmcr <- function(x, ...) {
  names(x)
}
