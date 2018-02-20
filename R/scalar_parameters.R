#' Scalar Parameters
#'
#' Gets the scalar parameter names for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A character vector of the parameter names.
#' @export
scalar_parameters <- function(x, ...) {
  UseMethod("parameters")
}

#' @export
scalar_parameters.term <- function(x, ...) {
  check_flag(scalar_only)
  parameters <- parameters_term(as.term(colnames(x)))
  unique <- unique(parameters)
  if (!scalar_only) return(unique)
  frequency <- vapply(unique, function(x) sum(parameters == x), 1L)
  unique[frequency == 1]
}

#' @export
scalar_parameters.mcmc <- function(x, ...) {
  check_flag(scalar_only)
  parameters <- parameters_term(as.term(colnames(x)))
  unique <- unique(parameters)
  if (!scalar_only) return(unique)
  frequency <- vapply(unique, function(x) sum(parameters == x), 1L)
  unique[frequency == 1]
}

#' @export
scalar_parameters.mcmc.list <- function(x, ...) {
  scalar_parameters(x[[1]], ...)
}

#' Parameters
#' @inheritParams parameters
#' @param scalar_only A flag indicating whether to only get scalar parameters.
#' @export
scalar_parameters.mcmcr <- function(x, scalar_only = FALSE, ...) {
  check_flag(scalar_only)
  if (scalar_only) {
    x <- lapply(x, dims)
    x <- purrr::keep(x, function(x) equals(x[3], 1L))
    x <- lapply(x, length)
    x <- purrr::keep(x, equals, 3L)
  }
  names(x)
}
