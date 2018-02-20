#' Collapse Chains
#'
#' Collapses chains into a single chain.
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @export
collapse_chains <- function(x, ...) {
  UseMethod("collapse_chains")
}

#' @export
collapse_chains.default <- function(x, ...) {
  nchains <- nchains(x)
  if (identical(nchains, 1L)) return(x)

  x <- lapply(1:nchains, FUN = function(chains, x) {subset(x, chains = chains)}, x = x)
  x <- Reduce(bind_iterations, x)
  x
}

#' @export
collapse_chains.mcmc.list <- function(x, ...) Reduce(bind_iterations, x)

#' @export
collapse_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, collapse_chains)
  class(x) <- "mcmcr"
  x
}
