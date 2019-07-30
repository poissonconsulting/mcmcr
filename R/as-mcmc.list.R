#' @method as.mcmc.list mcarray
#' @export
as.mcmc.list.mcarray <- function(x, ...) as.mcmc.list(as.mcmcarray(x))

#' @method as.mcmc.list nlists
#' @export
as.mcmc.list.nlist <- function(x, ...) {
  as.mcmc.list(coda::as.mcmc(x))
}

#' @method as.mcmc.list nlists
#' @export
as.mcmc.list.nlists <- function(x, ...) {
  as.mcmc.list(coda::as.mcmc(x))
}

#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, ...) {
  x <- lapply(1:nchains(x), function(chain, x) {subset(x, chains = chain)}, x = x)
  x <- lapply(x, as.mcmc)
  mcmc.list(x)
}

#' @method as.mcmc.list mcmc
#' @export
as.mcmc.list.mcmc <- function(x, ...) set_class(list(x), "mcmc.list")

#' @export
as.mcmc.list.mcmc.list <- function(x, ...) x

#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {
  pars <- pars(x)
  x <- lapply(x, as.mcmc.list)
  x <- mapply(x, pars, FUN = set_pars, SIMPLIFY = FALSE)
  x <- Reduce(bind_parameters, x)
  x
}
