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

  nchains <- nchains(object)
  niters <- niters(object)

  array <- apply(object, 3:n, stats::median)

  object <- list(array = array)
  object %<>% c(nchains = nchains, niters = niters)

  class(object) <- "summary.mcmcarray"
  object
}

#' @export
summary.mcmcr <- function(object, ...) {
  check_unused(...)

  nchains <- nchains(object)
  niters <- niters(object)
  object %<>% lapply(summary)

  class(object) <- "summary.mcmcr"
  object
}

#' @export
print.summary.mcmcarray <- function(x, ...) {
  check_unused(...)
  cat(x$array)
  cat("nchains: ", x$nchains)
  invisible(x)
}

#' @export
print.summary.mcmcr <- function(x, ...) {
  check_unused(...)

  cat("mcmcr:\n")
  lapply(x, print)
  invisible(x)
}
