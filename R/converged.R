#' Object Converged
#'
#' Test whether an object has converged.
#'
#' @param x An object.
#' @param ... Unused.
#' @export
converged <- function(x, ...) UseMethod("converged")

#' Object Converged
#'
#' Test whether an object has converged.
#'
#' @param x An mcmc object.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param by A string indicating whether to determine by "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the results as a (tbl) data frame.
#' @param ... Unused
#' @export
converged.default <-
  function(x, rhat = 1.1, esr = 0.33, by = "all", as_df = FALSE, ...) {
    .Deprecated("mcmc_converged")
    mcmc_converged(x, rhat = rhat, esr = esr, by = by, as_df = as_df)
}
