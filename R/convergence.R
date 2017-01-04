#' Convergence
#'
#' Get R-hat value(s) for JAGS objects
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the convergence value.
#' @export
convergence <- function(x, ...) {
  UseMethod("convergence", x)
}

#' @export
convergence.mcmc.list <- function(x, ...) {
  check_unused(...)
  x %<>% coda::gelman.diag(transform = TRUE, autoburnin = FALSE, multivariate = FALSE)

#  x %<>% round(2)
#
#   convergence <- round(gelman.diag(x, transform = TRUE, autoburnin = FALSE, multivariate = FALSE)$psrf[,"Point est.", drop = FALSE], 2)
#   rownames(convergence) <- vars
#   colnames(convergence) <- "convergence"
#   as.data.frame(convergence)
   x
}

#' @export
convergence.mcmcarray <- function(x, ...) {
  check_unused(...)
  convergence(as.mcmc.list(x))
}

#' @export
convergence.mcmcr <- function(x, ...) {
  check_unused(...)
  convergence(as.mcmc.list(x))
}
