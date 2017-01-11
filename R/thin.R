#' @export
thin.mcmcarray <- function(x, nthin = 1L, ...) {
  check_count(nthin)
  if (!nthin) error("nthin cannot be 0")

  if (nthin == 1) return(x)

  iterations <- seq(1, niters(x), by = nthin)
  x %<>% subset(iterations = as.integer(iterations))
  x
}

#' @export
thin.mcmcr <- function(x, nthin = 1L, ...) {
  check_count(nthin)
  if (!nthin) error("nthin cannot be 0")

  if (nthin == 1) return(x)

  x %<>% lapply(thin, nthin = nthin)
  class(x) <- "mcmcr"
  x
}
