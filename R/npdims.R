#' @export
universals::npdims

#' @inherit universals::npdims
#' @export
npdims.mcmc.list <- function(x, ...) vapply(pdims(x), length, 1L)

#' @inherit universals::npdims
#' @export
npdims.mcmcarray <- function(x, ...) length(pdims(x))

#' @inherit universals::npdims
#' @export
npdims.mcmcr <- function(x, ...) vapply(x, npdims, 1L)
