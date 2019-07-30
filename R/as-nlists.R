#' @export
as.nlists.mcmc <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}

#' @export
as.nlists.mcmc.list <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}

#' @export
as.nlists.mcmcr <- function(x, ...) {
  if(!identical(nchains(x), 1L)) err("x must only have 1 chain")
  x <- lapply(1:niters(x), FUN = subset_iteration_mcmcr, x)
  x <- lapply(x, set_class, "nlist")
  set_class(x, "nlists")
}
