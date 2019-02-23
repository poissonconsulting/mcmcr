#' Combine MCMC objects by chains.
#'
#' Combines two MCMC objects (with the same parameters and iterations) by chains.
#'
#' @param x an MCMC object.
#' @param x2 a second MCMC object
#' @param ... Unused.
#' @export
#' @examples
#' bind_chains(mcmcr_example, mcmcr_example)
bind_chains <- function(x, x2, ...) UseMethod("bind_chains")

#' @describeIn bind_chains Binds two mcarray objects by their chains
#' @export
bind_chains.mcarray <- function(x, x2, ...) {
  if (!is.mcarray(x2)) err("x2 must be an mcarray")

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- abind(x, x2, along = ndims(x))
  set_class(x, "mcarray")
}

#' @describeIn bind_chains Binds two mcmc objects by their chains
#' @export
bind_chains.mcmc <- function(x, x2, ...) {

  if (!coda::is.mcmc(x2)) err("x2 must be an mcmc")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    err("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  as.mcmc.list(list(x, x2))
}

#' @describeIn bind_chains Binds two mcmc.list objects by their chains
#' @export
bind_chains.mcmc.list <- function(x, x2, ...) {
  if (!(coda::is.mcmc.list(x2) || coda::is.mcmc(x2)))
    err("x2 must be an mcmc or mcmc.list")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    err("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- c(x, x2)
  set_class(x, "mcmc.list")
}

#' @describeIn bind_chains Binds two mcmcarray objects by their chains
#' @export
bind_chains.mcmcarray <- function(x, x2, ...) {

  if (!is.mcmcarray(x2)) err("x2 must be an mcmcarray")

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- abind(x, x2, along = 1, dimnames = FALSE)
  set_class(x, "mcmcarray")
}

#' @describeIn bind_chains Binds two mcmcr objects by their chains
#' @export
bind_chains.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x)) err("x2 must be an mcmcr")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    err("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- mapply(x, x2, FUN = bind_chains, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
