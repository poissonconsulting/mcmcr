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
collapse_chains.mcmcarray <- function(x, ...) {
  nchains <- nchains(x)
  if (identical(nchains, 1L)) return(x)
  y <- list()
  for (i in seq_len(nchains)) y[[i]] <- subset(x, chains = i)
  y %<>% purrr::reduce(bind_iterations)
  y
}


#' @export
collapse_chains.mcmcr <- function(x, ...) {
  x %<>% purrr::map(collapse_chains)
  class(x) <- "mcmcr"
  x
}
