#' Dimensions
#'
#' @param x The object.
#' @return An integer vector of the dimensions.
#' @export
#' @examples
#' dims(character())
#' dims(2:3)
#' dims(matrix(1:6, nrow = 2))
dims <- function(x) if (is.vector(x) || is.factor(x)) length(x) else dim(x)

#' Number of dimensions
#'
#' @param x The object.
#'
#' @return A count of the number of dimensions
#' @export
ndims <- function(x) {
  length(dims(x))
}

#' Number of MCMC Simulations
#'
#' The product of the number of chains and number of iterations in each chain.
#'
#' @param x The object.
#'
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
#' @param x The object.
#'
#' @return A count of the total number of samples.
#' @export
#' @examples
#' nsams(mcmcr_example)
nsams <- function(x) {
  nterms(x) * nsims(x)
}

#' Set Parameters
#'
#' @param x The object
#' @param parameters A character vector the new parameter names.
#'
#' @return A copy of the updated object
#' @export
#' @examples
#' set_parameters(mcmcr_example, c("gamma", "theta", "tau"))
set_parameters <- function(x, parameters) {
  parameters(x) <- parameters
  x
}

#' P-Value
#'
#' @param x A vector of mcmc samples
#'
#' @return A number indicating the p-value.
#' @export
#' @examples
#' pvalue(as.numeric(0:10))
pvalue <- function(x) {
  check_vector(x, 1, length = c(1, Inf))
  n <- length(x)
  d <- sum(x >= 0)
  p <- min(d, n - d) * 2
  p <- max(p, 1)
  round(p / n, 4)
}

#' Effective Sample Size
#'
#' @param x An mcmc object.
#' @param by A string indicating whether to determine by "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the results as a (tbl) data frame.
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

#' Converged
#'
#' @param x An mcmc object.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param by A string indicating whether to determine by "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the results as a (tbl) data frame.
#' @export
#' @examples
#' converged(mcmcr_example)
converged <- function(x, rhat = 1.1, esr = 0.33, by = "all", as_df = FALSE) {
  check_vector(rhat, c(1.0, 1.5), length = 1)
  check_probability(esr)

  esrs <- esr(x, by = "all", as_df = as_df)
  rhats <- rhat(x, by = "all", as_df = as_df)

  if(as_df) {
    converged <- esrs
    converged$converged <- converged$esr >= esr
    converged$esr <- NULL
    converged$converged <- converged$converged & rhats$rhat <= rhat
    return(converged)
  }
  converged <- unlist(esrs)
  converged <- converged >= esr
  rhats <- unlist(rhats)
  converged <- converged & rhats <= rhat
  utils::relist(converged, esrs)
}
