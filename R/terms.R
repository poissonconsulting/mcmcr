#' MCMC Object Terms
#'
#' Gets terms for an MCMC object.
#'
#' @param x A MCMC object.
#' @param ... Unused
#' @return A term vector.
#' @export
#' @seealso \code{stats::\link[stats]{terms}}
#' @examples
#' terms(mcmcr_example)
#' @name terms
NULL

#' @describeIn terms Get terms for an mcmc object
#' @export
terms.mcmc <- function(x, ...) as.term(x)

#' @describeIn terms Get terms for an mcmc.list object
#' @export
terms.mcmc.list <- function(x, ...) as.term(x)

#' @describeIn terms Get terms for an mcmcarray object
#' @export
terms.mcmcarray <- function(x, ...) as.term(x)

#' @describeIn terms Get terms for an mcmcr object
#' @export
terms.mcmcr <- function(x, ...) as.term(x)
