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
convergence.mcmcarray <- function(x, ...) {
  

  if (nchains(x) < 2) error("x must have at least two chains")

  dim <- dim(x)[-c(1,2)]

  x %<>% as.mcmc.list()

  x %<>% coda::gelman.diag(transform = TRUE, autoburnin = FALSE, multivariate = FALSE)
  x <- x$psrf[,"Point est."]
  x %<>% round(2)
  names(x) <- NULL

  if (length(dim) == 1)
    return(x)
  if (length(dim) == 2)
    return(matrix(x, ncol = dim[1], nrow = dim[2]))
  array(x, dim = dim)
  x
}

#' @export
convergence.mcmcr <- function(x, ...) {
  
  x %<>% vapply(function(x) max(convergence(x)), 1)
  max(x)
}
