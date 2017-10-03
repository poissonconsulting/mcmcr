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
#' @param efs A number specifying the minimum effective sampling rate.
#' @export
converged.mcmcarray <- function(x, rhat = 1.1, efs = 0.33, ...) {
  check_scalar(rhat, 1.0, 1.5)
  check_scalar(efs, 0.1, 1.0)
  rhat(x) < rhat & efs(x) > efs
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @param efs A number specifying the minimum effective sampling rate.
#' @export
converged.mcmcr <- function(x, rhat = 1.1, efs = 0.33, ...) {
  check_scalar(rhat, 1.0, 1.5)
  check_scalar(efs, 0.1, 1.0)
  rhat(x) < rhat & efs(x) > efs
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @param efs A number specifying the minimum effective sampling rate.
#' @export
converged.mcmcrs <- function(x, rhat = 1.1, efs = 0.33, ...) {
  check_scalar(rhat, 1.0, 1.5)
  check_scalar(efs, 0.1, 1.0)
  rhat(x) < rhat & efs(x) > efs
}
