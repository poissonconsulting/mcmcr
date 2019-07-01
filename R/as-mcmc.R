#' Coerce to an mcmc object
#'
#' Coerces MCMC objects to an \code{\link[coda]{mcmc}} object.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @seealso \code{coda::\link[coda]{mcmc}}
#' @examples
#' as.mcmc(subset(mcmcr_example, chains = 1L))
#' @name as.mcmc
NULL

#' @export
as.mcmc.mcarray <- function(x, ...) as.mcmc(as.mcmcarray(x))

#' @export
as.mcmc.mcmcarray <- function(x, ...) {
  if(nchains(x) != 1) err("x must only have 1 chain")
  terms <- terms(x)
  x <- apply(x, 1, identity)
  x <- matrix(x, ncol = length(terms))
  colnames(x) <- as.character(terms)
  as.mcmc(x)
}

#' @export
as.mcmc.mcmc <- function(x, ...) x

#' @export
as.mcmc.mcmcr <- function(x, ...) as.mcmc(as.mcmc.list(x))
