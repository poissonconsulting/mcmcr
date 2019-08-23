#' Collapse Chains
#'
#' Collapses an MCMC object's chains into a single chain.
#'
#' @param x An MCMC object.
#' @param ... Unused.
#' @name collapse_chains
#' @export
#' @examples
#' collapse_chains(mcmcr_example)
NULL

#' @export
collapse_chains.default <- function(x, ...) {
  nchains <- nchains(x)
  if (identical(nchains, 1L)) return(x)

  x <- lapply(1:nchains, FUN = function(chains, x) {subset(x, chains = chains)}, x = x)
  Reduce(bind_iterations, x)
}

#' @export
collapse_chains.mcmc.list <- function(x, ...) {
  as.mcmc.list(Reduce(bind_iterations, x))
}

#' @export
collapse_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, collapse_chains)
  set_class(x, "mcmcr")
}
