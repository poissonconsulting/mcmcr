#' @export
nlist::as_nlists

#' @inherit nlist::as_nlists
#' @export
as_nlists.mcmcr <- function(x, ...) {
  as_nlists(as_mcmc_list(x))
}
