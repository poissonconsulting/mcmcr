#' Coerce to an mcmc.list object
#'
#' Coerces MCMC objects to an \code{\link[coda]{mcmc.list}} object.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @name as.mcmc.list
NULL

#' @describeIn as.mcmc.list Coerces mcarray object to an mcmc.list object
#' @method as.mcmc.list mcarray
#' @export
as.mcmc.list.mcarray <- function(x, ...) as.mcmc.list(as.mcmcarray(x))

#' @describeIn as.mcmc.list Coerces mcmcarray object to an mcmc.list object
#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, ...) {
  x <- lapply(1:nchains(x), function(chain, x) {subset(x, chains = chain)}, x = x)
  x <- lapply(x, as.mcmc)
  mcmc.list(x)
}

#' @describeIn as.mcmc.list Coerces mcmc object to an mcmc.list object
#' @method as.mcmc.list mcmc
#' @export
as.mcmc.list.mcmc <- function(x, ...) set_class(list(x), "mcmc.list")

#' @export
as.mcmc.list.mcmc.list <- function(x, ...) x

#' @describeIn as.mcmc.list Coerces mcmcr object to an mcmc.list object
#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(x, as.mcmc.list)
  x <- mapply(x, parameters, FUN = set_parameters, SIMPLIFY = FALSE)
  x <- Reduce(bind_parameters, x)
  x
}
