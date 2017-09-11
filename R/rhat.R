#' Convergence
#'
#' Get R-hat value(s) for JAGS objects
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the rhat value.
#' @export
rhat <- function(x, ...) {
  UseMethod("rhat")
}

#' @export
rhat.mcmcarray <- function(x, by = "all", ...) {
  check_scalar(by, c("all", "parameter", "term"))
  if (nchains(x) < 2) error("x must have at least two chains")

  dim <- dim(x)[-c(1,2)]

  x %<>% as.mcmc.list()

  x %<>% coda::gelman.diag(transform = TRUE, autoburnin = FALSE, multivariate = FALSE)
  x <- x$psrf[,"Point est."]
  x %<>% round(2)
  names(x) <- NULL

  x[is.nan(x)] <- 1.00

  if (!isTRUE(all.equal(by, "term"))) return(max(x))

  if (length(dim) == 1)
    return(x)
  if (length(dim) == 2)
    return(matrix(x, ncol = dim[1], nrow = dim[2]))
  array(x, dim = dim)
}

#' @export
rhat.mcmcr <- function(x, by = "all", ...) {
  x %<>% purrr::map(rhat, by = by)
  if (isTRUE(all.equal(by, "all"))) return(max(unlist(x)))
  x
}

#' @export
rhat.mcmcrs <- function(x, by = "all", ...) {
  x %<>% purrr::reduce(bind_chains)
  rhat(x, by = by)
}

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
  check_scalar(rhat, 1.0, 1.2)
  rhat(x) < rhat
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @export
converged.mcmcr <- function(x, rhat = 1.1, ...) {
  check_scalar(rhat, 1.0, 1.2)
  rhat(x) < rhat
}

#' Is Converged
#'
#' @inheritParams converged
#' @param rhat A number specifying the rhat threshold.
#' @export
converged.mcmcrs <- function(x, rhat = 1.1, ...) {
  check_scalar(rhat, 1.0, 1.2)
  rhat(x) < rhat
}

