#' @export
universals::split_chains

#' @inherit universals::split_chains
#' @export
split_chains.mcmcarray <- function(x, ...) {
  nchains <- nchains(x)
  niters <- niters(x)
  n <- floor(niters / 2L)

  if(n == 0) abort_chk("`x` must have at least two iterations")

  y <- subset(x, iters = (n + 1L):(n * 2L))
  x <- subset(x, iters = 1:n)

  bind_chains(x, y)
}

#' @inherit universals::split_chains
#' @export
split_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, split_chains)
  class(x) <- "mcmcr"
  x
}
