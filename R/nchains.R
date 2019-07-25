#' Number of MCMC chains
#'
#' Gets the number of MCMC chains.
#'
#' @param x An MCMC object
#' @param ... Unused
#' @return A count indicating the number of MCMC chains
#' @export
#' @examples
#' nchains(mcmcr_example)
nchains <- function(x, ...) {
  UseMethod("nchains")
}

nchains.matrix <- function(x, ...) nrow(x)

#' @export
nchains.mcarray <- function(x, ...) unname(dim(x)[ndims(x)])

#' @export
nchains.mcmc <- function(x, ...) 1L

#' @export
nchains.mcmc.list <- function(x, ...) length(x)

#' @export
nchains.mcmcarray <- function(x, ...) dim(x)[1]

#' @export
nchains.mcmcr <- function(x, ...) nchains(x[[1]])

#' @export
nchains.mcmcrs <- function(x, ...) nchains(x[[1]])
