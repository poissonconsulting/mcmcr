#' Combine objects by chains.
#'
#' Combines two mcmc objects by chains.
#'
#' They must have the same parameter names, parameter dimensions and iterations.
#'
#' @param x an mcmc object.
#' @param x2 A second mcmc object
#' @param ... Unused.
#' @export
#' @examples
#' bind_chains(mcmcr_example, mcmcr_example)
bind_chains <- function(x, x2, ...) UseMethod("bind_chains")

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
