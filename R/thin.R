#' Thin MCMC Samples
#'
#' Thin an MCMC objects samples.
#'
#' @param x An MCMC object
#' @param nthin A count of the thinning rate.
#' @param ... Unused
#' @return The thinned object.
#' @export
#' @seealso \code{coda::\link[coda]{thin}}
#' @examples
#' thin(mcmcr_example, nthin = 10L)
#' @name thin
NULL

#' @describeIn thin Thin MCMC samples for an mcmcarray object
#' @export
thin.mcmcarray <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)

#' @describeIn thin Thin MCMC samples for an mcmcr object
#' @export
thin.mcmcr <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)

#' @describeIn thin Thin MCMC samples for an mcmcrs object
#' @export
thin.mcmcrs <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)
