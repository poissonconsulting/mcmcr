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

#' @describeIn nchains Number of MCMC chains for an mcarray object
#' @export
nchains.mcarray <- function(x, ...) unname(dim(x)[ndims(x)])

#' @describeIn nchains Number of MCMC chains for an mcmc object
#' @export
nchains.mcmc <- function(x, ...) 1L

#' @describeIn nchains Number of MCMC chains for an mcmc.list object
#' @export
nchains.mcmc.list <- function(x, ...) length(x)

#' @describeIn nchains Number of MCMC chains for an mcmcarray object
#' @export
nchains.mcmcarray <- function(x, ...) dim(x)[1]

#' @describeIn nchains Number of MCMC chains for an mcmcr object
#' @export
nchains.mcmcr <- function(x, ...) nchains(x[[1]])

#' @describeIn nchains Number of MCMC chains for an mcmcrs object
#' @export
nchains.mcmcrs <- function(x, ...) nchains(x[[1]])
