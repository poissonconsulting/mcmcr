#' Combine MCMC objects by chains.
#'
#' Combines two MCMC objects (with the same parameters and iterations) by chains.
#'
#' @param x An mcmc object.
#' @param x2 A second mcmc object
#' @param ... Unused.
#' @export
#' @examples
#' bind_chains(mcmcr_example, mcmcr_example)
bind_chains <- function(x, x2, ...) UseMethod("bind_chains")

#' @describeIn bind_chains Binds chains for two mcarray objects
#' @export
bind_chains.mcarray <- function(x, x2, ...) {
  if (!is.mcarray(x2)) error("x2 must be an mcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- abind::abind(x, x2, along = ndims(x))
  set_class(x, "mcarray")
}

#' @describeIn bind_chains Binds chains for two mcmc objects
#' @export
bind_chains.mcmc <- function(x, x2, ...) {

  if (!coda::is.mcmc(x2)) error("x2 must be an mcmc")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  coda::as.mcmc.list(list(x, x2))
}

#' @describeIn bind_chains Binds chains for two mcmc.list objects
#' @export
bind_chains.mcmc.list <- function(x, x2, ...) {
  if (!(coda::is.mcmc.list(x2) || coda::is.mcmc(x2))) error("x2 must be an mcmc or mcmc.list")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- c(x, x2)
  set_class(x, "mcmc.list")
}

#' @describeIn bind_chains Binds chains for two mcmcarray objects
#' @export
bind_chains.mcmcarray <- function(x, x2, ...) {

  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- abind::abind(x, x2, along = 1)
  set_class(x, "mcmcarray")
}

#' @describeIn bind_chains Binds chains for two mcmcr objects
#' @export
bind_chains.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x)) error("x2 must be an mcmcr")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- mapply(x, x2, FUN = bind_chains, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
