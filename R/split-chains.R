#' Split Chains
#'
#' Splits each chain in half to double the number chains and halve
#' the number of iterations.
#'
#' @param x An MCMC object.
#' @param ... Unused.
#' @export
#' @examples
#' split_chains(mcmcr_example)
split_chains <- function(x, ...) {
  UseMethod("split_chains")
}

#' @describeIn split_chains Split Chains for an mcmcarray object
#' @export
split_chains.mcmcarray <- function(x, ...) {
  nchains <- nchains(x)
  niters <- niters(x)
  n <- floor(niters / 2L)

  if(n == 0) error("x must have at least two iterations")

  y <- subset(x, iterations = (n + 1L):(n * 2L))
  x <- subset(x, iterations = 1:n)

  bind_chains(x, y)
}

#' @describeIn split_chains Split Chains for an mcmcr object
#' @export
split_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, split_chains)
  class(x) <- "mcmcr"
  x
}
