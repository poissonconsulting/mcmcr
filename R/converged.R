#' Is Converged
#'
#' Tests whether x has converged.
#'
#' @param x The object to test.
#' @param ... Unused
#' @return A flag indicating whether the test was positive.
#' @export
converged <- function(x, ...) {
  UseMethod("converged")
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @export
converged.mcmcarray <- function(x, rhat = 1.1, ...) {
  check_scalar(rhat, 1.0, 1.5)
  rhat(x) < rhat
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @export
converged.mcmcr <- function(x, rhat = 1.1, ...) {
  check_scalar(rhat, 1.0, 1.5)
  rhat(x) < rhat
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @export
converged.mcmcrs <- function(x, rhat = 1.1, ...) {
  check_scalar(rhat, 1.0, 1.5)
  rhat(x) < rhat
}
