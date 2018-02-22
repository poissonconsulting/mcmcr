#' @export
thin.mcmc <- function(x, nthin = 1L, ...) .thin(x, nthin = nthin, ...)

#' @export
thin.mcmc.list <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)

#' @export
thin.mcmcarray <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)

#' @export
thin.mcmcr <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)

#' @export
thin.mcmcrs <- function(x, nthin = 1L,...) .thin(x, nthin = nthin, ...)
