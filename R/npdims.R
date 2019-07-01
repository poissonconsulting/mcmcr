#' @export
npdims.mcmc.list <- function(x, ...) lapply(pdims(x), length)

#' @export
npdims.mcmcr <- function(x, ...) vapply(x, npdims, 1L)
