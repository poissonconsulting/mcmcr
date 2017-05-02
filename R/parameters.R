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
parameters <- function(x, ...) {
  UseMethod("parameters")
}

#' Parameters
#'
#' Sets the parameter names for an object.
#'
#' @param x The object.
#' @param value A character vector of the parameter names.
#' @export
`parameters<-` <- function(x, value) {
  UseMethod("parameters<-", x)
}

#' @export
parameters.mcmcr <- function(x, ...) {
  names(x)
}

#' @export
`parameters<-.mcmcr` <- function(x, value) {
  check_vector(value, "", min_length = length(x), max_length = length(x))
  check_unique(value)
  names(x) <- value
  x
}
