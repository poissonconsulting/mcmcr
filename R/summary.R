#' @export
summary.mcmcarray <- function(object, ...) {


  summary <- list(estimates = estimates(object),
                  nchains = nchains(object),
                  niters = niters(object))

  class(summary) <- "summary.mcmcarray"
  summary
}

#' @export
summary.mcmcr <- function(object, ...) {
  arrays <- lapply(object, summary)

  summary <- list(arrays = list(arrays))

  class(summary) <- "summary.mcmcr"
  summary
}
