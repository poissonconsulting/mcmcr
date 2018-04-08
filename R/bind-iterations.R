#' Combine two MCMC objects by iterations
#'
#' Combines two MCMC objects (with the same parameters and chains) by iterations.
#'
#' @param x an MCMC object
#' @param x2 a second MCMC object
#' @param ... unused
#' @export
#' @examples
#' bind_iterations(mcmcr_example, mcmcr_example)
bind_iterations <- function(x, x2, ...) {
  UseMethod("bind_iterations")
}

#' @describeIn bind_iterations Binds two mcarray objects by their iterations
#' @export
bind_iterations.mcarray <- function(x, x2, ...) {
  if (!is.mcarray(x2)) error("x2 must be an mcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- abind::abind(x, x2, along = ndims(x)-1)
  set_class(x, "mcarray")
}

#' @describeIn bind_iterations Binds two mcmc objects by their iterations
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
  as.mcmc(x)
}

#' @describeIn bind_iterations Binds two mcmc.list objects by their iterations
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
  set_class(x, "mcmc.list")
}

#' @describeIn bind_iterations Binds two mcmcarray objects by their iterations
#' @export
bind_iterations.mcmcarray <- function(x, x2, ...) {

  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")

  if (!identical(pdims(x), pdims(x2)))
    error("x and x2 must have the same parameter dimensions")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- abind::abind(x, x2, along = 2)
  set_class(x, "mcmcarray")
}

#' @describeIn bind_iterations Binds two mcmcr objects by their iterations
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
  set_class(x, "mcmcr")
}
