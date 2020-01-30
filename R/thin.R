#' @export
coda::thin

#' Thin MCMC Object
#'
#' Thins an MCMC object's iterations.
#'
#' @inheritParams params
#' @return The thinned MCMC object.
#' @export
#' @examples
#' thin(mcmcr_example, nthin = 10L)
thin.default <- function(x, nthin = 1L,...) {
  chk_whole_number(nthin)
  chk_gte(nthin, 1)
  iters <- seq(1L, niters(x), by = nthin)
  subset(x, iters = iters)
}
