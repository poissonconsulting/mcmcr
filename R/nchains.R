#' Number of MCMC chains
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC chains in object.
#' @export
nchains <- function(x, ...) {
  UseMethod("nchains")
}

nchains.matrix <- function(x, ...) {
  nrow(x)
}

#' @export
nchains.mcarray <- function(x, ...) {
  nchains <- dim(x)[ndims(x)]
  names(nchains) <- NULL
  nchains
}

#' @export
nchains.mcmc <- function(x, ...) {
  1L
}

#' @export
nchains.mcmc.list <- function(x, ...) {
  length(x)
}

#' @export
nchains.mcmcarray <- function(x, ...) {
  dim(x)[1]
}

#' @export
nchains.mcmcr <- function(x, ...) {
  nchains(x[[1]])
}
