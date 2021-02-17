#' P-Value
#' Effective Sample Size
#'
#' Calculates the effective sample size based on [esr()].
#'
#' @inheritParams params
#' @param x An MCMC object.
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
