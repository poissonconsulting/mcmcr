#' Split Chains
#'
#' Splits each chain into two chains.
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @export
split_chains <- function(x, ...) {
  UseMethod("split_chains")
}

#' @export
split_chains.mcmcarray <- function(x, ...) {
  nchains <- nchains(x)
  niters <- niters(x)
  n <- floor(niters / 2L)

  y <- subset(x, iterations = (n + 1L):(n * 2L))
  x %<>% subset(iterations = 1:n)

  bind_chains(x, y)
}


#' @export
split_chains.mcmcr <- function(x, ...) {
  x %<>% purrr::map(split_chains)
  class(x) <- "mcmcr"
  x
}
