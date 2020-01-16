#' @export
as.mcmc.nlists <- function(x, ...) {
  as.mcmc(as.mcmcr(x))
}

#' @export
as.mcmc.mcarray <- function(x, ...) as.mcmc(as.mcmcarray(x))

#' @export
as.mcmc.mcmcarray <- function(x, ...) {
  chk_identical(nchains(x), 1L)
  term <- as.term(x)
  x <- apply(x, 1, identity)
  x <- matrix(x, ncol = length(term))
  colnames(x) <- as.character(term)
  as.mcmc(x)
}

#' @export
as.mcmc.mcmc <- function(x, ...) x

#' @export
as.mcmc.mcmcr <- function(x, ...) as.mcmc(as.mcmc.list(x))
