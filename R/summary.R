#' @export
summary.mcmcarray <- function(object, ...) {
  check_unused(...)
  estimates <- estimates(object)

  summary <- list(estimates = estimates)
  summary %<>% c(nchains = nchains(object), niters = niters(object))

  class(summary) <- "summary.mcmcarray"
  summary
}

#' @export
summary.mcmcr <- function(object, ...) {
  check_unused(...)

  arrays <- lapply(object, summary)

  summary <- list(arrays = list(arrays))

  class(summary) <- "summary.mcmcr"
  summary
}
