#' Collapse Chains
#'
#' Collapses an MCMC object's chains into a single chain.
#'
#' @param x An MCMC object.
#' @param ... Unused.
#' @export
#' @examples
#' collapse_chains(mcmcr_example)
collapse_chains <- function(x, ...) {
  UseMethod("collapse_chains")
}

#' @describeIn collapse_chains Collapse an MCMC object's chains into a single chain
#' @export
collapse_chains.default <- function(x, ...) {
  nchains <- nchains(x)
  if (identical(nchains, 1L)) return(x)

  x <- lapply(1:nchains, FUN = function(chains, x) {subset(x, chains = chains)}, x = x)
  Reduce(bind_iterations, x)
}

#' @describeIn collapse_chains Collapse an mcmc.list object's chains into a single chain
#' @export
collapse_chains.mcmc.list <- function(x, ...) {
  Reduce(bind_iterations, x)
}
#' @describeIn collapse_chains Collapse an mcmcr object's chains into a single chain
#' @export
collapse_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, collapse_chains)
  set_class(x, "mcmcr")
}
