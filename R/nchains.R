#' Number of MCMC chains
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC chains in object.
#' @export
nchains <- function(x, ...) {
  UseMethod("nchains")
}

#' @export
nchains.mcarray <- function(x, ...) {

  nchains <- dim(x)[ndims(x)]
  names(nchains) <- NULL
  nchains
}

#' @export
nchains.mcmcarray <- function(x, ...) {

  dim(x)[1]
}

#' @export
nchains.mcmcr <- function(x, ...) {

  nchains(x[[1]])
}
