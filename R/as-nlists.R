
#' @export
as.nlists.mcmcr <- function(x, ...) {
  x <- collapse_chains(x)
  x <- lapply(1:niters(x), FUN = subset_iteration_mcmcr, x)
  x <- lapply(x, set_class, "nlist")
  set_class(x, "nlists")
}

#' @export
as.nlists.mcmc.list <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}

#' @export
as.nlists.mcmc <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}
