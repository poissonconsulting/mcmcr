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
print.summary.mcmcr <- function(x, ...) {
  check_unused(...)

  lapply(x$arrays, print)
  cat("nchains: ", x$nchains, "\n")
  cat("niters: ", x$niters, "\n")
  invisible(x)
}
