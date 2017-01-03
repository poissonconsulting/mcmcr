#' @export
print.mcmcarray <- function(x, ...) {
  check_unused(...)
  print(summary(x))
  invisible(x)
}

#' @export
print.mcmcr <- function(x, ...) {
  check_unused(...)
  print(summary(x))
  invisible(x)
}

#' @export
summary.mcmcarray <- function(object, ...) {
  check_unused(...)

  n <- ndims(object)
  apply(object, 3:n, stats::median)
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

#' @export
print.summary.mcmcr <- function(x, ...) {
  check_unused(...)

  lapply(x$arrays, print)
  cat("nchains: ", x$nchains, "\n")
  cat("niters: ", x$niters, "\n")
  invisible(x)
}
