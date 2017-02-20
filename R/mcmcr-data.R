#' MCMC Data
#'
#' Combines an mcmcr object with samples from a single vector with a data frame with the same number of rows.
#' The resultant object can be filtered or summarized or the coef calculated.
#'
#' @param mcmcr An mcmcr object
#' @param data A data.frame
#' @return An object of class \code{mcmc_datar}
#' @export
mcmcr_data <- function(mcmcr, data) {
  mcmcr_data <- list(mcmcr = mcmcr,
                     data = data)

  class(mcmcr_data) <- "mcmcr_data"
  check_mcmcr_data(mcmcr_data)
}
