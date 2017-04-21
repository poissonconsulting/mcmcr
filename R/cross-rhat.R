#' Convergence
#'
#' Get R-hat value(s) for convergence between two mcmc objects
#'
#' @param x An mcmc object.
#' @param x2 A second mcmc object.
#' @param ... Unused.
#' @return A number of the rhat value.
#' @export
cross_rhat <- function(x, x2, ...) {
  UseMethod("cross_rhat")
}

#' @export
cross_rhat.mcmcarray <- function(x, x2, ...) {
  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray object")
  x %<>% collapse_chains()
  x2 %<>% collapse_chains()
  x %<>% bind_chains(x2)
  rhat(x, ...)
}

#' @export
cross_rhat.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x2)) error("x2 must be an mcmcr object")
  x %<>% collapse_chains()
  x2 %<>% collapse_chains()
  x %<>% bind_chains(x2)
  rhat(x, ...)
}

#' Have Two Objects Converged
#'
#' Tests whether two objects have converged on the same answers.
#'
#' @param x The first object to test.
#' @param x2 The second object to test against.
#' @param ... Unused
#' @return A flag indicating whether the test was positive.
#' @export
cross_converged <- function(x, x2, ...) {
  UseMethod("cross_converged")
}

#' Is Converged
#'
#' @inheritParams cross_converged
#' @param rhat A number specifying the rhat threshold.
#' @export
cross_converged.mcmcarray <- function(x, x2, rhat = 1.2, ...) {
  check_number(rhat)
  cross_rhat(x, x2) <= rhat
}

#' Is Converged
#'
#' @inheritParams cross_converged
#' @param rhat A number specifying the rhat threshold.
#' @export
cross_converged.mcmcr <- function(x, x2, rhat = 1.2, ...) {
  check_number(rhat)
  cross_rhat(x, x2) <= rhat
}
