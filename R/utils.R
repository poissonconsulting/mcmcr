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
#' data frame or list.
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
