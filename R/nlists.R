subset_mcmcarray_iteration <- function(x, iteration) {
  x <- abind::asub(x, iteration, 2L, drop = FALSE)
  dim <- dim(x)[-c(1,2)]
  if(length(dim) == 1) dim <- NULL
  dim(x) <- dim
  x
}

subset_iteration_mcmcr <- function(iteration, x) {
  lapply(x, subset_mcmcarray_iteration, iteration = iteration)
}

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
