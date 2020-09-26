#' @export
nlist::as_nlists

#' @inherit nlist::as_nlists
#' @export
as_nlists.mcmc.list <- function(x, ...) {
  as_nlists(as.mcmcr(x))
}

#' @inherit nlist::as_nlists
#' @export
as_nlists.mcmcr <- function(x, ...) {
  chk_identical(nchains(x), 1L)
  x <- lapply(1:niters(x), FUN = subset_iteration_mcmcr, x)
  x <- lapply(x, set_class, "nlist")
  set_class(x, "nlists")
}
