#' MCMC Object Converged
#'
#' Test whether an MCMC object has converged.
#'
#' @param x An MCMC object.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param by A string indicating whether to determine by "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the results as a (tbl) data frame.
#' @param ... Unused
#' @export
#' @examples
#' mcmc_converged(mcmcr_example)
mcmc_converged <- function(x, rhat = 1.1, esr = 0.33,
                           by = "all", as_df = FALSE, ...) {
  UseMethod("mcmc_converged")
}

#' @describeIn mcmc_converged Test whether an MCMC object has converged
#' @export
mcmc_converged.default <-
  function(x, rhat = 1.1, esr = 0.33, by = "all", as_df = FALSE, ...) {
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
