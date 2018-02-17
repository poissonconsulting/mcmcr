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
parameters.term <- function(x, scalar_only = FALSE, ...) {
  check_flag(scalar_only)
  parameters <- parameters_term(as.term(colnames(x)))
  unique <- unique(parameters)
  if (!scalar_only) return(unique)
  frequency <- vapply(unique, function(x) sum(parameters == x), 1L)
  unique[frequency == 1]
}


#' Parameters
#' @inheritParams parameters
#' @param scalar_only A flag indicating whether to only get scalar parameters.
#' @export
parameters.mcmc <- function(x, scalar_only = FALSE, ...) {
  check_flag(scalar_only)
  parameters <- parameters_term(as.term(colnames(x)))
  unique <- unique(parameters)
  if (!scalar_only) return(unique)
  frequency <- vapply(unique, function(x) sum(parameters == x), 1L)
  unique[frequency == 1]
}

#' Parameters
#' @inheritParams parameters
#' @param scalar_only A flag indicating whether to only get scalar parameters.
#' @export
parameters.mcmc.list <- function(x, scalar_only = FALSE, ...) {
  parameters(x[[1]], scalar_only = scalar_only, ...)
}

#' Parameters
#' @inheritParams parameters
#' @param scalar_only A flag indicating whether to only get scalar parameters.
#' @export
parameters.mcmcr <- function(x, scalar_only = FALSE, ...) {
  check_flag(scalar_only)
  if (scalar_only) {
    x <- lapply(x, dims)
    x <- purrr::keep(x, function(x) equals(x[3], 1L))
    x <- lapply(x, length)
    x <- purrr::keep(x, equals, 3L)
  }
  names(x)
}

#' @export
`parameters<-.mcmcr` <- function(x, value) {
  check_vector(value, "", length = length(x))
  check_unique(value)
  names(x) <- value
  x
}
