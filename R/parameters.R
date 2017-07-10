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

#' Number of parameters
#' @inheritParams npars
#' @param scalar_only A flag indicating whether to only count scalar parameters.
#' @export
npars.mcmcr <- function(x, scalar_only = FALSE, ...) {
  length(parameters(x, scalar_only = scalar_only))
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

#' Parameters
#' @inheritParams parameters
#' @param scalar_only A flag indicating whether to only get scalar parameters.
#' @export
parameters.mcmcr <- function(x, scalar_only = FALSE, ...) {
  check_flag(scalar_only)
  if (scalar_only) {
    x %<>%
      purrr::map(dims) %>%
      purrr::keep(function(x) magrittr::equals(x[3], 1L)) %>%
      purrr::map(length) %>%
      purrr::keep(magrittr::equals, 3L)
  }
  names(x)
}

#' @export
`parameters<-.mcmcr` <- function(x, value) {
  check_vector(value, "", min_length = length(x), max_length = length(x))
  check_unique(value)
  names(x) <- value
  x
}
