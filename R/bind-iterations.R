#' Combines objects by iterations.
#'
#' Combines two mcmc objects by iterations.
#'
#' They must have the same parameter names, parameter dimensions and chains
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object
#' @param ... Unused.
#' @export
bind_iterations <- function(x, x2, ...) {
  UseMethod("bind_iterations")
}

#' @export
bind_iterations.mcarray <- function(x, x2, ...) {
  if (!is.mcarray(x2)) error("x2 must be an mcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- abind::abind(x, x2, along = ndims(x)-1)
  class(x) <- "mcarray"
  x
}

#' @export
bind_iterations.mcmc <- function(x, x2, ...) {
  if (!is.mcmc(x2)) error("x2 must be an mcmc")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- abind::abind(x, x2, along = 1)
  coda::as.mcmc(x)
}

#' @export
bind_iterations.mcmc.list <- function(x, x2, ...) {
  if (!(is.mcmc.list(x2) || is.mcmc(x2))) error("x2 must be an mcmc.list")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- mapply(x, x2, FUN = bind_iterations, SIMPLIFY = FALSE)
  class(x) <- "mcmc.list"
  x
}

#' @export
bind_iterations.mcmcarray <- function(x, x2, ...) {

  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- abind::abind(x, x2, along = 2)
  class(x) <- "mcmcarray"
  x
}

#' @export
bind_iterations.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x2)) error("x2 must be an mcmcr")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- mapply(x, x2, FUN = bind_iterations, SIMPLIFY = FALSE)
  class(x) <- "mcmcr"
  x
}
