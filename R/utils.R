#' P-Value
#' Effective Sample Size
#'
#' Calculates the effective sample size based on [esr()].
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

  if (as_df) {
    x$ess <- as.integer(round(x$esr * nsims))
    x$esr <- NULL
    return(x)
  }
  esr <- unlist(x)
  esr <- as.integer(round(esr * nsims))
  utils::relist(esr, x)
}
