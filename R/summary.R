#' @export
summary.mcmcarray <- function(object, ...) {
  check_unused(...)

  summary <- list(estimates = estimates(object),
                  nchains = nchains(object),
                  niters = niters(object))

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
