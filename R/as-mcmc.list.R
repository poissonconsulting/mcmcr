#' @inherit generics::tidy
#' @method as.mcmc.list mcarray
#' @export
as.mcmc.list.mcarray <- function(x, ...) as.mcmc.list(as.mcmcarray(x))

#' @inherit generics::tidy
#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, ...) {
  x <- lapply(1:nchains(x), function(chain, x) {subset(x, chains = chain)}, x = x)
  x <- lapply(x, as.mcmc)
  mcmc.list(x)
}

#' @inherit generics::tidy
#' @method as.mcmc.list mcmc
#' @export
as.mcmc.list.mcmc <- function(x, ...) set_class(list(x), "mcmc.list")

#' @inherit generics::tidy
#' @export
as.mcmc.list.mcmc.list <- function(x, ...) x

#' @inherit generics::tidy
#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {
  pars <- pars(x)
  x <- lapply(x, as.mcmc.list)
  x <- mapply(x, pars, FUN = set_pars, SIMPLIFY = FALSE)
  x <- Reduce(bind_parameters, x)
  x
}
