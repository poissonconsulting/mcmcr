#' @export
plot.mcmcarray <- function(x, ...) {
  check_unused(...)
  plot(as.mcmc.list(x))
}

#' @export
plot.mcmcr <- function(x, ...) {
  check_unused(...)
  plot(as.mcmc.list(x))
}
