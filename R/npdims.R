#' @export
npdims.mcmc.list <- function(x, ...) vapply(pdims(x), length, 1L)

#' @export
npdims.mcmcr <- function(x, ...) vapply(x, npdims, 1L)
