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
print.summary.mcmcarray <- function(x, ...) {
  check_unused(...)

  print(x$estimates)
  cat("  nchains: ", x$nchains, "\n")
  cat("  niters: ", x$niters, "\n")
  invisible(x)
}

#' @export
print.summary.mcmcr <- function(x, ...) {
  check_unused(...)

  lapply(x$arrays, print)
  invisible(x)
}
