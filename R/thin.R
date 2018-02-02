#' @export
thin.mcmcarray <- function(x, nthin = 1L, ...) {
  check_count(nthin)
  nthin <- max(nthin, 1L)

  if (nthin == 1) return(x)

  iterations <- seq(1, niters(x), by = nthin)
  x <- subset(x, iterations = as.integer(iterations))
  x
}

#' @export
thin.mcmcr <- function(x, nthin = 1L, ...) {
  x <- llply(x, thin, nthin = nthin)
  class(x) <- "mcmcr"
  x
}
