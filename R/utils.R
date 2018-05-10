#' Dimensions
#'
#' @param x A vector, matrix or array.
#' @return An integer vector of the dimensions.
#' @export
#' @examples
#' dims(character())
#' dims(2:3)
#' dims(matrix(1:6, nrow = 2))
dims <- function(x) if (is.vector(x) || is.factor(x)) length(x) else dim(x)

#' Number of dimensions
#'
#' @param x A vector, matrix or array.
#'
#' @return A count of the number of dimensions
#' @export
ndims <- function(x) {
  length(dims(x))
}

#' Number of MCMC Simulations
#'
#' The product of the number of chains and number of iterations (in each chain).
#'
#' @param x The MCMC object.
#' @return A count of the total number of simulations.
#' @export
#' @examples
#' nsims(mcmcr_example)
nsims <- function(x) {
  nchains(x) * niters(x)
}

#' Number of MCMC Samples
#'
#' The product of the number of simulations and the number of terms.
#'
#' @param x The MCMC object.
#' @return A count of the total number of samples.
#' @export
#' @examples
#' nsams(mcmcr_example)
nsams <- function(x) {
  nterms(x) * nsims(x)
}

#' P-Value
#'
#' Calculates the p-value.
#'
#' @param x A vector of MCMC value
#' @return A number indicating the p-value.
#' @export
#' @examples
#' pvalue(as.numeric(0:10))
pvalue <- function(x) {
  check_vector(x, c(1, NA), length = c(1, Inf))
  n <- length(x)
  d <- sum(x >= 0)
  p <- min(d, n - d) * 2
  p <- max(p, 1)
  round(p / n, 4)
}

#' Effective Sample Size
#'
#' Calculates the effective sample size based on \code{\link{esr}}.
#'
#' @param x An MCMC object.
#' @param by A string indicating whether to determine by "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the results as a
#' tibble or list.
#' @export
#' @examples
#' ess(mcmcr_example)
ess <- function(x, by = "all", as_df = FALSE) {
  nsims <- nsims(x)
  x <- esr(x, by = by, as_df = as_df)

  if(as_df) {
    x$ess <- as.integer(round(x$esr * nsims))
    x$esr <- NULL
    return(x)
  }
  esr <- unlist(x)
  esr <- as.integer(round(esr * nsims))
  utils::relist(esr, x)
}
