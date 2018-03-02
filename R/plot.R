#' @export
plot.mcmcarray <- function(x, ...) plot(as.mcmc.list(x))

#' @export
plot.mcmcr <- function(x, ...) plot(as.mcmc.list(x))
