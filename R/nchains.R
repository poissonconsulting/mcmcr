#' Number of MCMC chains
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC chains in object.
#' @export
nchains <- function(x, ...) {
  UseMethod("nchains", x)
}

#' @export
nchains.mcarray <- function(x, ...) {
  check_unused(...)
  names(dim(x)) <- NULL
  nchains <- dim(x)[ndims(x)]
  nchains
}

#' @export
nchains.mcmcarray <- function(x, ...) {
  check_unused(...)
  dim(x)[1]
}

#' @export
nchains.mcmcr <- function(x, ...) {
  check_unused(...)
  nchains(x[[1]])
}
