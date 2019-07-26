#' Number of Simulations
#'
#' Gets the number of simulations of an MCMC object.
#'
#' @param x The MCMC object
#' @param ... Unused.
#' @return A count of the number of simulations.
#' @export
#'
#' @examples
#' nlist::nsims(mcmcr::mcmcr_example)
nsims.default <- function(x, ...) nchains(x) * niters(x)
