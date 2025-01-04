#' @export
coda::as.mcmc

#' @inherit universals::nchains
#' @export
as.mcmc.nlists <- function(x, ...) {
  as.mcmc(as.mcmcr(x))
}

#' @inherit coda::as.mcmc
#' @export
as.mcmc.mcarray <- function(x, ...) as.mcmc(as.mcmcarray(x))

#' @inherit coda::as.mcmc
#' @export
as.mcmc.mcmcarray <- function(x, ...) {
  chk_identical(nchains(x), 1L)
  term <- as_term(x)
  x <- apply(x, 1, identity)
  x <- matrix(x, ncol = length(term))
  colnames(x) <- as.character(term)
  as.mcmc(x)
}

#' @inherit coda::as.mcmc
#' @export
as.mcmc.mcmc <- function(x, ...) x

#' @inherit coda::as.mcmc
#' @export
as.mcmc.mcmcr <- function(x, ...) as.mcmc(as.mcmc.list(x))
