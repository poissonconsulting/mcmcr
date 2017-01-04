#' @export
summary.mcmcarray <- function(object, fun = stats::median, ...) {
  n <- ndims(object)
  apply(object, 3:n, fun, ...)
}

#' @export
summary.mcmcr <- function(object, ...) {
  check_unused(...)

  arrays <- lapply(object, summary)

  summary <- list(arrays = list(arrays))
  summary %<>% c(nchains = nchains(object), niters = niters(object))

  class(summary) <- "summary.mcmcr"
  summary
}
