#' Number of MCMC samples in a single chain
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC samples in a chain.
#' @export
niters <- function(x, ...) {
  UseMethod("niters", x)
}

#' @export
niters.mcarray <- function(x, ...) {
  check_unused(...)
  names(dim(x)) <- NULL
  dim(x)[ndims(x) - 1]
}

#' @export
niters.mcmcarray <- function(x, ...) {
  check_unused(...)
  dim(x)[2]
}

#' @export
niters.mcmcr <- function(x, ...) {
  check_unused(...)
  niters(x[[1]])
}
