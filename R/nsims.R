#' @export
nsims.mcarray <- function(x) nchains(x) * niters(x)

#' @export
nsims.mcmc <- function(x) nchains(x) * niters(x)

#' @export
nsims.mcmc.list <- function(x) nchains(x) * niters(x)

#' @export
nsims.mcmcarray <- function(x) nchains(x) * niters(x)

#' @export
nsims.mcmcr <- function(x) nchains(x) * niters(x)

#' @export
nsims.mcmcrs <- function(x) nchains(x) * niters(x)
