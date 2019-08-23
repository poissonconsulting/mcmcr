#' Number of MCMC chains
#'
#' Gets the number of chains of an MCMC object.
#'
#' @param x An MCMC object
#' @param ... Unused
#' @return A count indicating the number of MCMC chains
#' @export
#' @name nchains
#' @examples
#' nchains(mcmcr::mcmcr_example)
NULL

nchains.matrix <- function(x, ...) nrow(x)

#' @describeIn nchains Number of chains of an mcarray object
#' @export
nchains.mcarray <- function(x, ...) unname(dim(x)[ndims(x)])

#' @describeIn nchains Number of chains of an mcmc object
#' @export
nchains.mcmc <- function(x, ...) 1L

#' @describeIn nchains Number of chains of an mcmc.list object
#' @export
nchains.mcmc.list <- function(x, ...) length(x)

#' @describeIn nchains Number of chains of an mcmcarray object
#' @export
nchains.mcmcarray <- function(x, ...) dim(x)[1]

#' @describeIn nchains Number of chains of an mcmcr object
#' @export
nchains.mcmcr <- function(x, ...) nchains(x[[1]])

#' @describeIn nchains Number of chains of an mcmcrs object
#' @export
nchains.mcmcrs <- function(x, ...) nchains(x[[1]])
